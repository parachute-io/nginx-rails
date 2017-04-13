FROM nginx:1.11.5

RUN apt-get update && apt-get install -y --no-install-recommends apache2-utils

VOLUME ["/usr/src/app/public"]

RUN rm /etc/nginx/conf.d/default.conf
COPY etc/nginx.conf /etc/nginx/nginx.conf
COPY etc/app.conf /etc/nginx/conf.d/

COPY bin/start .

CMD ["./start"]
