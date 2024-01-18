FROM redis:6-alpine

EXPOSE 6379
# Needs to be mapped to 172.20.0.2
# docker run --network=lila -d -p 6379:6370 --ip 172.20.0.2 redis:0.30
CMD ["redis-server"]