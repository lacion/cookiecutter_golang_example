# Build Stage
FROM lacion/alpine-golang-buildimage:1.12.4 AS build-stage

LABEL app="build-generated code example"
LABEL REPO="https://github.com/lacion/generated code example"

ENV PROJPATH=/go/src/github.com/lacion/generated code example

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/lacion/generated code example
WORKDIR /go/src/github.com/lacion/generated code example

RUN make build-alpine

# Final Stage
FROM lacion/alpine-base-image:latest

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/lacion/generated code example"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/generated code example/bin

WORKDIR /opt/generated code example/bin

COPY --from=build-stage /go/src/github.com/lacion/generated code example/bin/generated code example /opt/generated code example/bin/
RUN chmod +x /opt/generated code example/bin/generated code example

# Create appuser
RUN adduser -D -g '' generated code example
USER generated code example

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/generated code example/bin/generated code example"]
