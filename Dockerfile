FROM python:3.9.5-slim

RUN apt-get update \
    && apt-get -y install libpq-dev gcc git \
    && pip install psycopg2

WORKDIR /app
RUN git clone https://github.com/NovationMenu/menu.git .
# RUN sed -i "s/localhost/${DOCKER_HOST}/g" /app/app.py
RUN sed -i "s/localhost/pg_container/g" /app/app.py

RUN pip install -r requirements.txt

RUN export FLASK_APP=app.py && export FLASK_ENV=development

ENTRYPOINT [ "bash", "-l", "-c" ]
CMD [ "python3 app.py" ]
