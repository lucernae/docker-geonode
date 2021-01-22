#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
ARG BASE_IMAGE=geonode/spcgeonode:django-3.1
FROM ${BASE_IMAGE}

LABEL maintainer="Rizky Maulana Nugraha <lana.pcfre@gmail.com>"
LABEL org="Kartoza"

RUN mkdir -p /usr/share/man/man1
RUN apt-get update -y && apt-get -y --allow-downgrades --allow-remove-essential --allow-unauthenticated install yui-compressor rpl mdbtools git

WORKDIR /spcgeonode

RUN rm -rf *; rm -rf .git;
# Efficiently retrieve just specific commit
ARG BASE_GEONODE_REPO=https://github.com/GeoNode/geonode.git
ARG BASE_GEONODE_REPO_NAME=origin
ARG BASE_GEONODE_COMMIT=3.1
RUN git init; git remote add ${BASE_GEONODE_REPO_NAME} ${BASE_GEONODE_REPO};
RUN git fetch ${BASE_GEONODE_REPO_NAME} ${BASE_GEONODE_COMMIT}; git reset --hard FETCH_HEAD
RUN pip install -r requirements.txt

RUN pip uninstall -y django-geonode-mapstore-client

ADD REQUIREMENTS.txt /REQUIREMENTS.txt
RUN pip install -r /REQUIREMENTS.txt

ADD entrypoint.sh /entrypoint.sh
ADD initialize.py /initialize.py
ADD uwsgi.conf /uwsgi.conf
ENTRYPOINT ["/entrypoint.sh"]
CMD ["uwsgi", "--ini", "/uwsgi.conf"]
