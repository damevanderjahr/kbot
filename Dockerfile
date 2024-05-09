FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make build

FROM scratch
LABEL org.opencontainers.image.source https://github.com/damevanderjahr/kbot
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ENTRYPOINT [ "./kbot", "start" ]
