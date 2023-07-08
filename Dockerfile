FROM python:3.9.12-slim-buster


ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Update packages
RUN apt-get update \
    && apt-get install -y libmariadb-dev  \
    && apt-get install -y build-essential \
    && apt-get install -y libpq-dev \
    && apt-get install -y gcc \
    && apt-get install -y ffmpeg

# Install requirements
COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /requirements.txt
RUN pip install uwsgi

# Copy Codes
COPY core/ /app
RUN chmod 777 /app
WORKDIR /app

# Create User
RUN adduser --disabled-password django
USER django
