ARG image_tag="6.2.3"
FROM docker.elastic.co/elasticsearch/elasticsearch:${image_tag}

USER root

ARG jq_version="1.5"
ARG jq_sha256="c6b3a7d7d3e7b70c6f51b706a3b90bd01833846c54d32ca32f0027f00226ff6d"
RUN cd /tmp \
    && curl -o /usr/bin/jq -SL "https://github.com/stedolan/jq/releases/download/jq-${jq_version}/jq-linux64" \
    && echo "${jq_sha256}  /usr/bin/jq" | sha256sum -c - \
    && chmod +x /usr/bin/jq

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_c_customized_image
ADD elasticsearch.yml /usr/share/elasticsearch/config/
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml

USER elasticsearch

ARG es_cloud_k8s_plugin_version="6.2.3.2"
RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:${es_cloud_k8s_plugin_version}
