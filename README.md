## Тема проектной работы

Создание процесса непрерывной поставки для приложения с применением Практик CI/CD и быстрой обратной связью

Для развертывания выбрано двухкомпонентное приложение:

- бот Search Engine Crawler 
  https://github.com/express42/search_engine_crawler
- Search Engine UI 
  https://github.com/express42/search_engine_ui


## Требования к проектной работе:

- [x] Автоматизированные процессы создания и управления платформой

    - [x]  Ресурсы GCP 
    - [x]  Инфраструктура для CI/CD - Gitlab  
    - [x]  Инфраструктура для сбора обратной связи - Prometheus, Grafana, EFK, Kibana

- [x] Использование практики IaC (Infrastructure as Code) для управления конфигурацией и инфраструктурой

    Для развертывания компонентов приложения реализованы 2 подхода:
    
      -  инфраструктура развертывается в docker-контейнерах
            - построение образов и размещение в dockerHub с помощью Make-файла 
            - развертывание на локальной машине через docker-compose
      - инфраструктура развертывается в GKE (Google kubernetes engine) с использованием terraform 

    Для развертывания инфраструктуры ci/cd, мониторинга и логгирования использовался terraform              

    Были использованы провайдеры:
    
            - google
            - google-beta
              Ресурсы:
                - google_container_cluster
                - google_container_node_pool  
            - helm
              Ресурсы:   
                - helm_release

- [x] Настроен процесс CI/CD 
      - с качестве CI/CD платформы был выбран Gitlab-omnibus 
      - развертывание платформы с помощью terraform-провайдера helm

- [x] Все, что имеет отношение к проекту хранится в Git

- [x] Настроен процесс сбора обратной связи 

   - [x] Мониторинг (сбор метрик, визуализация)
 
       - [x] платформа для мониторинга Prometheus
       - [x] сбор метрик с двух компонент приложения
       - [x] сбор метрик docker-контейнеров с помощью Cadvisor 
       - [x] сбор метрик сущностей k8s (деплойменты, репликасеты, ...) с помощью kube-statemetrics
       - [x] сбор метрик с нод с помощью nodeExporter
       - [ ] алертинг

    - [x] Логирование (опционально) 

        - [x] ElasticSearch (база данных + поисковый движок) 
        - [x] Fluentd (отправитель и агрегатор логов) 
        - [x] Kibana (веб-интерфейс для запросов в хранилище и отображения их результатов)

    - [ ] Трейсинг (опционально)
    - [ ] ChatOps (опционально)

    
- [x] Документация 

    - [x] -  README по работе с репозиторием
    - [x] -  Описание приложения и его архитектуры
    - [x] -  How to start?
    - [x] -  ScreenCast
    - [x] -  CHANGELOG с описанием выполненной работы

Скринкаст от 08.11.2020 - https://yadi.sk/d/MbCyDT5aRI6cIQ?w=1


