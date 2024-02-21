FROM stevegeomet/base:latest

ENV DIR=ukk
ENV INDEX_DIR=/var/www/html/$DIR
ENV TEXT="Welcome to "

RUN mkdir $INDEX_DIR
RUN echo "<?php echo '$TEXT' . gethostname() ?>" > $INDEX_DIR/index.php
RUN sed -i "41s,.*,root /var/www/html/${DIR};," /etc/nginx/sites-available/default 
RUN sed -i "44s,.*,index index.php index.html index.htm index.nginx-debian.html;," /etc/nginx/sites-available/default
RUN sed -i "56s,.*,location ~ \.php$ {," /etc/nginx/sites-available/default
RUN sed -i "57s,.*,include snippets/fastcgi-php.conf;," /etc/nginx/sites-available/default
RUN sed -i "60s,.*,fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;," /etc/nginx/sites-available/default
RUN sed -i "63s,.*,}," /etc/nginx/sites-available/default

EXPOSE 80
CMD ["bash", "/script.sh"]
