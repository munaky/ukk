FROM stevegeomet/base:latest

ENV DIR=speedtest
ENV INDEX_DIR=/var/www/html/$DIR

RUN mkdir $INDEX_DIR
RUN sed -i "41s,.*,root /var/www/html/${DIR};," /etc/nginx/sites-available/default

COPY index.html $INDEX_DIR
COPY css $INDEX_DIR
COPY 5mb.bin $INDEX_DIR

EXPOSE 80
CMD ["bash", "/script.sh"]
