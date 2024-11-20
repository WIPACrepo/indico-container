ARG VERSION=latest

ARG pip="/opt/indico/.venv/bin/pip"

FROM ghcr.io/indico/indico:$VERSION

# all the installations etc can be done using the unprivileged indico user
USER indico

RUN ${pip} install https://github.com/WIPACrepo/indico-sso-plugin.git

ENTRYPOINT ["/opt/indico/docker_entrypoint.sh"]
EXPOSE 59999
