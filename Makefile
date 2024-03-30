APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := damevanderjahr
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux #linux darvin windows
TARGETARCH=arm64 #amd64 arn64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/damevanderjahr/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	(docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} || true) && (rm -rf kbot || true)

linux: 
	make TARGETOS=linux TARGETARCH=amd64 build

windows:
	make TARGETOS=windows TARGETARCH=amd64 build

arm:
	make TARGETOS=linux TARGETARCH=arm64 build

macos:
	make TARGETOS=darwin TARGETARCH=arm64 build