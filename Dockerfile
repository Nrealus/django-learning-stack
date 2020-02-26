FROM python:3.6

ENV PYTHONUNBUFFERED 1
RUN mkdir -p /opt/services/djangoapp/src

ARG DJANGO_SETTINGS_MODULE
ENV DJANGO_SETTINGS_MODULE=${DJANGO_SETTINGS_MODULE}

COPY Pipfile Pipfile.lock /opt/services/djangoapp/src/
WORKDIR /opt/services/djangoapp/src
RUN pip install pipenv && pipenv install --system

COPY . /opt/services/djangoapp/src
RUN cd djproject && python3 manage.py collectstatic --no-input --settings=${DJANGO_SETTINGS_MODULE}

EXPOSE 8000
CMD ["gunicorn", "-c", "config/gunicorn/conf.py", "--bind", ":8000", "--chdir", "djproject", "djproject.wsgi:application"]
