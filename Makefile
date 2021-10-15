start:
	mv nginx.conf nginx.conf.bak
	python3 generate-conf.py
	docker-compose up --build -d

stop:
	docker-compose stop

