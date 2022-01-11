start:
	if [ -e nginx.conf ]; then mv --force nginx.conf nginx.conf.bak; fi;
	python3 generate-conf.py
	docker-compose up --build --detach

stop:
	docker-compose stop

validate-certs:
	python3 validate-certs.py

generate-certs:
	MISSING_CERTS=$$(python3 print-missing-certs.py); \
	if [ -z "$$MISSING_CERTS" ]; then \
		echo "Found no certificates to generate"; \
	else \
		docker-compose run --service-ports certbot certonly \
			--domains "$$MISSING_CERTS" \
			--non-interactive \
			--standalone \
			--agree-tos \
			--register-unsafely-without-email; \
	fi;

renew-certs:
	docker-compose run --service-ports certbot renew
