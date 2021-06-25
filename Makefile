SHELL := /bin/bash
CMD_PKG := github.com/feitian124/i9n
VERSION := $(shell cat ./pkg/version.go | grep "Version\ =" | sed -e s/^.*\ //g | sed -e s/\"//g)
GO_BUILD_OPTION := -trimpath -tags netgo

.PHONY: all check format vet build install uninstall release clean test generate build-linux package

# nfpm: go get -u github.com/goreleaser/nfpm/cmd/nfpm
tools := nfpm

$(tools):
	@command -v $@ >/dev/null 2>&1 || (echo "$@ is not found, plese install it."; exit 1;)

help:
	@echo "Please use \`make <target>\` where <target> is one of"
	@echo "  check      to format and vet"
	@echo "  build      to create bin directory and build i9n"
	@echo "  install    to install i9n to /usr/local/bin/i9n"
	@echo "  uninstall  to uninstall i9n"
	@echo "  release    to release i9n"
	@echo "  clean      to clean build and test files"
	@echo "  test       to run test"
	@echo "  package    to make deb and rpm package for linux distribution"

check: format vet

format:
	@echo "go fmt"
	@go fmt ./...
	@echo "ok"

vet:
	@echo "go vet"
	@go vet ./...
	@echo "ok"

generate:
	@echo "generate code..."
	@go generate ./...
	@echo "Done"

build: tidy generate check
	@echo "build i9n"
	@mkdir -p ./bin
	@go build ${GO_BUILD_OPTION} -race -o ./bin/i9n ${CMD_PKG}
	@echo "ok"

build-linux: tidy generate check
	@echo "build i9n for linux amd64"
	@mkdir -p ./bin/linux
	@GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build ${GO_BUILD_OPTION} -o ./bin/linux/i9n ${CMD_PKG}
	@echo "ok"

install: build
	@echo "install i9n to GOPATH"
	@cp ./bin/i9n ${GOPATH}/bin/i9n
	@echo "ok"

uninstall:
	@echo "delete /usr/local/bin/i9n"
	@rm -f /usr/local/bin/i9n
	@echo "ok"

release:
	@echo "release i9n"
	@-rm -rf ./release/*
	@mkdir -p ./release

	@echo "build for linux"
	@GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build ${GO_BUILD_OPTION} -o ./bin/linux/i9n_v${VERSION}_linux_amd64 ${CMD_PKG}
	@tar -C ./bin/linux/ -czf ./release/i9n_v${VERSION}_linux_amd64.tar.gz i9n_v${VERSION}_linux_amd64

	@echo "build for macOS"
	@GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 go build ${GO_BUILD_OPTION} -o ./bin/macos/i9n_v${VERSION}_macos_amd64 ${CMD_PKG}
	@tar -C ./bin/macos/ -czf ./release/i9n_v${VERSION}_macos_amd64.tar.gz i9n_v${VERSION}_macos_amd64

	@echo "build for windows"
	@GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go build ${GO_BUILD_OPTION} -o ./bin/windows/i9n_v${VERSION}_windows_amd64.exe ${CMD_PKG}
	@tar -C ./bin/windows/ -czf ./release/i9n_v${VERSION}_windows_amd64.tar.gz i9n_v${VERSION}_windows_amd64.exe

	@echo "build deb and rpm"
	@mkdir -p ./release/${VERSION}
	@cp ./bin/linux/i9n_v${VERSION}_linux_amd64 ./bin/linux/i9n
	@echo "Packaging deb for i9n..."
	@nfpm pkg --target ./release/i9n_v${VERSION}_linux_amd64.deb
	@echo "Packaging rpm for i9n..."
	@nfpm pkg --target ./release/i9n_v${VERSION}_linux_amd64.rpm
	@echo "ok"

clean:
	@rm -rf ./bin
	@rm -rf ./release
	@rm -rf ./coverage

test:
	@echo "run test"
	@go test -gcflags=-l -race -coverprofile=coverage.txt -covermode=atomic -v ./...
	@go tool cover -html="coverage.txt" -o "coverage.html"
	@echo "ok"

tidy:
	@echo "Tidy and check the go mod files"
	@go mod tidy
	@go mod verify
	@echo "Done"

package: nfpm build-linux
	@mkdir -p ./release/${VERSION}
	@echo "Packaging deb for i9n..."
	@nfpm pkg --target ./release/${VERSION}/i9n_v${VERSION}_linux_amd64.deb
	@echo "Packaging rpm for i9n..."
	@nfpm pkg --target ./release/${VERSION}/i9n_v${VERSION}_linux_amd64.rpm
	@echo "done"
