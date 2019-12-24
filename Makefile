.PHONY: all build test publish

APP ?= go
ORG ?= code-build
HUB ?=

IID   = $(if $(HUB), ${HUB}/${ORG}/${APP}, ${ORG}/${APP}) 
LOCAL = ${ORG}/${APP}
TEST  = ${ORG}/${APP}:test
REPO  = ${ORG}/${APP}

all: build test publish

build: Dockerfile
	@docker build -t ${IID} - < $^
	@docker tag ${IID} ${LOCAL}

test:
	@docker build -t ${TEST} test
	@docker run --rm --privileged ${TEST}
	@docker rmi ${TEST}

publish:
	@test -z ${HUB} && { echo "Unable to publish! Please configure env variable HUB."; exit 128; } || echo ""
	@cdk deploy -a "ts-node ecr.ts" -c repo=${ORG}/${APP}
	@eval $(shell aws ecr get-login --no-include-email --region eu-west-1)
	@docker push ${IID}
