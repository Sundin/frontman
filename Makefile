start:
	python generate-conf.py
	docker-compose up --build -d

stop:
	docker-compose stop