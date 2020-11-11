## Развертывам GKE (Google kubernetes engine) cluster
1) 
Устанавливаем на машине для развертывания terraform, Google Cloud SDK

2)

- cd infra/terraform/
- terraform init
- terraform apply ---auto-approve

переключаемся на контекст созданного k8s кластера:

gcloud container clusters get-credentials webserf --zone "зона" --project "имя проекта"

## Развертываем инфраструктуру мониторинга

Накатываем на наш развернутый кластер nginx, инфраструктуру мониторинга и логгирвания

- cd infra/terraform/helm/monitoring
- terraform apply ---auto-approve

Смотрим EXTERNAL-IP для nginx-nginx-ingress-controller:
kubectl get svc 

Прописываем в /etc/hosts:

EXTERNAL-IP webserf-prometheus webserf-grafana crawler-ui webserf-kibana

## Поднимаем Gitlab

- cd gitlab-omnibus
- terraform apply ---auto-approve 
Смотрим EXTERNAL-IP для nginx:

- kubectl get svc 

Прописываем в /etc/hosts:

EXTERNAL-IP itokareva-search-engine-crawler-unit-test itokareva-search-engine-ui-review 

## Сборка, unit-test, тестовый deploy и cleanup приложения с feature - веток в Gitlab
 
- При внесении изменений на feature-ветке в source-каталоге Gitlab_ci/search_engine_crawler или 
Gitlab_ci/search_engine_ui и последующих commit и push original "имя ветки" в gitlab запустится pipeline,
который соберет докер образ, выложит его на dockerHub, выполнит unit-test и развернет приложение
webserf в namespace unittest для crawler или review для ui . 
Для проверки работоспособности приложения нужно перейти в пункт меню environmentы на gitlab, нажать
пиктограмму 'open'. ui- интерфейс приложения откроется в браузере и можно будет протестировать его работу.
Затем в ручном режиме можно удалить развернутое приложение в том же pipeline.

## Сборка, unit-test, тестовый deploy и cleanup приложения с master - ветки

- При внесении изменений на master-ветке в source-каталоге search_engine_crawler или search_engine_ui 
и последующих commit и push original "имя ветки" в gitlab запустится pipeline, который выгрузит 
образ с dockerHub, поставит тэг релиза и загрузит на dockerHub с новым тэгом.

- При внесении изменений в каталоге приложения Gitlab_ci/webserf-deploy на ветке master запустится сборочный конвейер, 
который развернет приложение в окружении staging (namespace staging).
Открыть приложение так же можно через пункт меню environments в gitlab.

- В ручном режиме можно продолжить развертывание приложения на окружении production (namespace production)
Открыть приложение так же можно через пункт меню environments в gitlab.

## Локальная сборка, развертывание приложения

-  cобираем приложение из корневого каталога одной из команд:
   make crawler_build
   make ui_build
   make build
в зависимости от того хотим построить crawler, ui или оба.

- размещаем образ на dockerHub из корневого каталога одной из команд:

  make crawler_push
  make ui_push
  make push
  
 в зависимости от того хотим разместить crawler, ui или оба. 
 
 - запускаем сборку из корневого каталога:
 
   docker-compose up -f docker/docker-compose.yaml
   
 ## Мониторинг
 
 Мониторинг реализован на Prometheus. 
  -  сбор метрик с двух компонент приложения
  -  сбор метрик docker-контейнеров с помощью Cadvisor 
  -  сбор метрик сущностей k8s (деплойменты, репликасеты, ...) с помощью kube-statemetrics
  -  сбор метрик с нод с помощью nodeExporter
  -  алертинг  - настроены правила на alert: InstanceDown и настроена нотификация в слаке, но не "не взлетает" один из двух контейнеров в поде. Не удлось победить.
  
  В веб-браузере набираем http://webserf-prometheus/targets - смотрим наши цели, или /graph и вычисляем наши мерики.
  
  Визуализация реализована в Grafana.
  
  - выполнены настройки конфигурации так, чтобы Grafana открывалась с уже преднастроенным DadaSource и дашбордами.
  
  ## Логгирование 
  
  
