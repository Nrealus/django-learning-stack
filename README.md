My first stack setup : Docker + (Django + Gunicorn (WSGI Application)) + multiple PostgreSQL databases + Nginx as reverse proxy and static files server

Used as a learning project, and a base to deploy web apps developped for learning purposes and fun. 

Main inspiration sources : 

https://github.com/pawamoy/docker-nginx-postgres-django-example

https://github.com/ruddra/docker-django


Future improvements could include :
-Numpy, Scipy, Pandas, Pillow for simulations / data science things / maths studd
-A testing environment (tox)
-Celery + Redis (as broker) integration
-Better way to deal with environments (instead of one big settings.py file, load env vars from file ?)

---------
---------

export DJANGO_MODULE_SETTINGS="djproject.mysettings" before building docker images, where "mysettings" comes from the "mysettings.py" settings file you can adapt from the default "settings.py" file in the djproject directory.

