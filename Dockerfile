FROM golang:alpine as builder
COPY . /go/src/github.com/silenceper/http-demo/
RUN cd /go/src/github.com/silenceper/http-demo/ \
  && go get -v \
  && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine
MAINTAINER silenceper <silenceper@gmail.com>
COPY --from=builder /go/src/github.com/silenceper/http-demo/app /bin/app
ENTRYPOINT ["/bin/app"]
EXPOSE 8080
