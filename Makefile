start:
	if [ -a nginx.conf ]; then mv nginx.conf nginx.conf.bak; fi;
	python3 generate-conf.py
	docker context ls
	docker-compose up --build --detach

stop:
	docker-context ls
	docker-compose stop
