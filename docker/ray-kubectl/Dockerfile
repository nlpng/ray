# The stress_test Docker image build a self-contained Ray instance for launching Ray.
FROM golang:alpine as build_env
#FROM alpine:3.8 as build_env

RUN apk add --no-cache git

RUN go get -u github.com/golang/dep/cmd/dep
RUN go get github.com/pusher/k8s-auth-example \
    && cd $GOPATH/src/github.com/pusher/k8s-auth-example \
    && dep ensure \
    && go build -o k8s-auth


ADD https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ENV HOME=/config
RUN set -x \
    && apk add --no-cache curl ca-certificates \
    && chmod +x /usr/local/bin/kubectl

FROM alpine:3.8

COPY --from=build_env /usr/local/bin/kubectl /usr/local/bin/kubectl
