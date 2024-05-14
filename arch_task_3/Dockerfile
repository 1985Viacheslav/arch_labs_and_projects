FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget gnupg
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libpoco-dev

COPY . /app
COPY init.py /app/init.py

WORKDIR /app

RUN rm -rf build && mkdir build && cd build && cmake .. && make

# Установка зависимостей для Python
RUN apt-get install -y python3 python3-pip
# RUN pip3 install pymongo
RUN pip3 install --break-system-packages pymongo

EXPOSE 8080

CMD ["sh", "-c", "sleep 10 && python3 /app/init.py && ./build/messenger_service"]