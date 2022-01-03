start:
	if [ -a nginx.conf ]; then mv nginx.conf nginx.conf.bak; fi;
	python3 generate-conf.py
ifdef context
	docker-compose --context $(context) up --build --detach 
else
	docker context ls
	docker-compose up --build --detach
endif

stop:
ifdef context
	docker-compose --context $(context) stop
else
	docker-context ls
	docker-compose stop
endif
