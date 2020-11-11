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
 
## Сборка, unit-test, тестовый deploy и cleanup приложения с feature - веток

1) При внесении изменений на feature-ветке в source-каталоге Gitlab_ci/search_engine_crawler или 
Gitlab_ci/search_engine_ui и последующих commit и push original "имя ветки" в gitlab запустится pipeline,
который соберет докер образ, выложит его на dockerHub, выполнит unit-test и развернет приложение
webserf в namespace unittest для crawler или review для ui . 
Для проверки работоспособности приложения нужно перейти в пункт меню environmentы на gitlab, нажать
пиктограмму 'open'. ui- интерфейс приложения откроется в браузере и можно будет протестировать его работу.
Затем в ручном режиме можно удалить развернутое приложение в том же pipeline.

2) При внесении изменений на master-ветке в source-каталоге search_engine_crawler или search_engine_ui 
и последующих commit и push original "имя ветки" в gitlab запустится pipeline, который выгрузит 
образ с dockerHub, поставит тэг релиза и загрузит на dockerHub с новым тэгом.

3) При внесении изменений в каталоге приложения Gitlab_ci/webserf-deploy на ветке master запустится сборочный конвейер, 
который развернет приложение в окружении staging (namespace staging).
Открыть приложение так же можно через пункт меню environments в gitlab.

4) В ручном режиме можно продолжить развертывание приложения на окружении production (namespace production)
Открыть приложение так же можно через пункт меню environments в gitlab.

