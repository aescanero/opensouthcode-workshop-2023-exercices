FROM docker.io/golang:alpine3.17

MAINTAINER Alejandro Escanero Blanco <alejandro.escanero@accenture.com>

USER 0

# syntax=docker/dockerfile:1
WORKDIR /go/src/github.com/alexellis/href-counter/
COPY go.mod .
COPY go.sum .
COPY app.go .

RUN apk --no-cache add ca-certificates && mkdir /data

RUN go get -d -v golang.org/x/net/html \
  && CGO_ENABLED=0 go build -a -installsuffix cgo -o app . && cp app /data/.

RUN chgrp -R 0 /data && chmod -R g=u /data
  
USER 1001

WORKDIR /data/

CMD ["./app"]
