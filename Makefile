CRAWLER_VERSION = 1.0 
CRAWLER_UI_VERSION = 1.0
CURRENT_USERNAME = itokareva
# BUILD
build:  search_engine_crawler ui_build

VPATH = search_engine_crawleir:search_engine_ui
crawler_build: search_engine_crawler 
	docker build -t $(CURRENT_USERNAME)/crawler:$(CRAWLER_VERSION) $^ 
ui_build: search_engine_ui
	docker build -t $(CURRENT_USERNAME)/crawler_ui:$(CRAWLER_UI_VERSION) $^
# PUSH	
push: crawler_push ui_push
crawler_push:  
	docker push $(CURRENT_USERNAME)/crawler:$(CRAWLER_VERSION)
ui_push:
	docker push $(CURRENT_USERNAME)/crawler_ui:$(CRAWLER_UI_VERSION)



