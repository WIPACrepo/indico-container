ARG VERSION=latest

FROM ghcr.io/indico/indico:$VERSION

USER root

RUN set -ex && \
    apt-get update && \
    apt-get -y install nginx && \
    apt-get clean

RUN chown indico:indico /var/lib/nginx

COPY nginx.conf /etc/nginx/nginx.conf

# all the installations etc can be done using the unprivileged indico user
USER indico

RUN /opt/indico/.venv/bin/pip install git+https://github.com/WIPACrepo/indico-sso-plugin.git
RUN /opt/indico/.venv/bin/pip install git+https://github.com/WIPACrepo/Indico-plugin-zoom-timetable@ui-changes
RUN /opt/indico/.venv/bin/pip install --force-reinstall git+https://github.com/WIPACrepo/flask-multipass.git@fix-amr-claim-validation

ENTRYPOINT ["/opt/indico/docker_entrypoint.sh"]
EXPOSE 59999
