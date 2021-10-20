FROM docker.elastic.co/elasticsearch/elasticsearch:7.14.1

## data
#RUN mkdir /data && chown -R elasticsearch:elasticsearch /data
#COPY ./data/ /data/
#RUN chmod 755 /data/*

## wait-for-it
#ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /utils/wait-for-it.sh
#RUN chown -R elasticsearch:elasticsearch /utils/wait-for-it.sh && chmod 755 /utils/wait-for-it.sh

## RUN
RUN echo 'discovery.type: single-node' >> config/elasticsearch.yml
RUN /usr/local/bin/docker-entrypoint.sh elasticsearch -p /tmp/epid & /bin/bash /utils/wait-for-it.sh -t 0 localhost:9200 -- /data/es_init.sh; kill $(cat /tmp/epid) && wait $(cat /tmp/epid); exit 0;

