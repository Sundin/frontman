start:
	if [ -a nginx.conf ]; then mv nginx.conf nginx.conf.bak; fi;
	python3 generate-conf.py
	docker-compose up --build -d

stop:
	docker-compose stop

