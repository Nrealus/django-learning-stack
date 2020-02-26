.PHONY: docs clean

RUNCOM = docker-compose run --rm djangoapp /bin/bash -c
EXECCOM = docker exec -it djstack_web /bin/bash -c

#all: build #test

build-dev:
	export DJANGO_SETTINGS_MODULE="djproject.settings.settings_dev"
	docker-compose build

build-prod:
	export DJANGO_SETTINGS_MODULE="djproject.settings.settings_prod"
	docker-compose build

run:
	docker-compose up

exec-ctnr:
	$(EXECCOM) $(filter-out $@,$(MAKECMDGOALS))
# BAD PRACTICE APPARENTLY BUT EH

#migrate:
#	$(RUNCOM) 'cd djproject; for db in default database2; do ./manage.py migrate --database=$${db}; done'

migrate:
	$(EXECCOM) 'cd djproject; for db in default database2; do ./manage.py migrate --database=$${db}; done'

collectstatic:
	$(EXECCOM) './djproject/manage.py collectstatic --no-input'

#collectstatic:
#	docker-compose run --rm djangoapp djproject/manage.py collectstatic --no-input

#check: checksafety checkstyle

#test:
#	$(RUNCOM) "pip install tox && tox -e test"

#checksafety:
#	$(RUNCOM) "pip install tox && tox -e checksafety"

#checkstyle:
#	$(RUNCOM) "pip install tox && tox -e checkstyle"

#coverage:
#	$(RUNCOM) "pip install tox && tox -e coverage"

#clean:
#	rm -rf build
#	rm -rf djproject.egg-info
#	rm -rf dist
#	rm -rf htmlcov
#	rm -rf .tox
#	rm -rf .cache
#	rm -rf .pytest_cache
#	find . -type f -name "*.pyc" -delete
#	rm -rf $(find . -type d -name __pycache__)
#	rm .coverage
#	rm .coverage.*

dockerclean:
	docker system prune -f
	docker system prune -f --volumes
