FROM python:3.10-alpine AS base

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . ./

EXPOSE 5000

CMD python server.py