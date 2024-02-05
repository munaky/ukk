FROM stevegeomet/web:latest

ARG DIR=ukk
ARG TEXT="Welcome to"
ENV INDEX_DIR=/var/www/html/${DIR}

#RUN mkdir $INDEX_DIR
RUN echo "<?php echo '$TEXT' . gethostname() ?>" > $INDEX_DIR/index.php 





EXPOSE 80
CMD ["bash", "/script.sh"]
