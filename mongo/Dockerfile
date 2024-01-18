FROM mongo:5.0

VOLUME lila_mongo_data:/data/db

EXPOSE 27017
# Needs to be mapped to 172.20.0.3
# docker run --network=lila -d -p 27017:27017 --ip 172.20.0.3 mongo:0.30
# docker network create --subnet=172.20.0.0/16 lila
CMD ["mongod"]