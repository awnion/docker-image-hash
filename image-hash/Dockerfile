# FROM docker:20.10.17-alpine3.16
FROM node:18-slim
RUN apt-get update && apt-get install -yq docker.io

WORKDIR /
COPY docker-extension/vm/commands/gosh-image-sha.sh /
RUN chmod +x /gosh-image-sha.sh
ENTRYPOINT [ "/gosh-image-sha.sh" ]
