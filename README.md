


## Django stack Docker setup

This is my first Docker and Web project. It is a Docker base setup for web application development with Django.

This is a project developed for learning purposes. It may be a good base to deploy various web apps, for fun or for learning purposes.

**Usage and explanation** 

- The Django application is served by Gunicorn (WSGI application)
- An arbitrary amount of Postgres databases can easily be added to the setup. Simply add an `mynewdb.env` file  to the `/config/db` directory with similary parameters to those in `database2.env`, it's easy to figure out. Then, edit `docker-compose.yml` and add a service for `mynewdb`, taking inspiration from the `database2` service. No need to add anything to Django `settings.py` file, it scans `config/db` and adds to the `DATABASES` dictionary automatically
- NginX is used as a reverse proxy and static files server. Static and media files are persistently stored in volumes.
- Python dependencies are managed through `pipenv`, with`Pipfile` and `Pipfile.lock`. Also, I personally recommend to run `export PIPENV_VENV_IN_PROJECT="enabled"` and then `pipenv lock` to create the Python virtual environment you'll be using for development in the project's root. (`.venv` directory)

- It easy to switch and set environment settings. By default, two environments are available, development and production (though they are no different here)
- To setup a new environment, create a new `mynewenv.env` file in `config/django` which will contain environment variables loaded into a Django settings file located in `djproject/djproject/settings/`. Create a `mynewsettings.py` file in that directory, taking inspiration from `settings_dev.py`, for example. Change the `dotenv.load_dotenv(os.path.join(os.path.dirname(BASE_DIR),"config/django/djangodev.env"))` line to `dotenv.load_dotenv(os.path.join(os.path.dirname(BASE_DIR),"config/django/mynewenv.env"))`. Finally, set the `DJANGO_SETTINGS_MODULE` environment variable in your shell to `djproject.settings.mynewsettings`. Now, when you'll run `docker-compose up`, your new settings and new environment will be used. I recommend creating a `make` command in `Makefile` just like `build-dev`, for example.
- To build docker images in development environment, run `make build-dev` or `make build-prod` for production. Then run `make run` to start the containers.
- Finally, go to `localhost:8000/testapp` to check if it works

**Main inspirations** 

https://github.com/pawamoy/docker-nginx-postgres-django-example

https://github.com/ruddra/docker-django

**Bugs or problems, possible improvements in the future or interesting additions** (in no particular order)

- `.dockerignore` doesn't work...
- Set up an easy test environment, possibly with `tox`, `bandit`(..?) or other stuff
- Security cheat sheet : https://snyk.io/blog/python-security-best-practices-cheat-sheet/
- Add `numpy`, `scipy`, `pandas` to allow for cool math stuff or data science projects
- Celery + Redis (as broker) integration
