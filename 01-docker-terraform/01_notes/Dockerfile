FROM python:3.11.4-slim-buster

# set working directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends wget

# install dependencies
RUN pip install pandas sqlalchemy psycopg2-binary

# copy project file
COPY ingest_data.py ingest_data.py

ENTRYPOINT ["python", "ingest_data.py"]