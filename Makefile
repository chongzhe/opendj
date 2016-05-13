# If you edit this with an IDE beware of converting tabs to spaces (Make wants tabs)
.PHONY: clean download openam openidm opendj ssoadm ssoconfig openig apache-agent resty foo

# Override these with env vars to change the defaults
TAG ?= nightly
REPO ?=forgerock
#PUSH ?= true

all: openam openidm opendj ssoadm ssoconfig apache-agent resty

# Clean up any downloaded artifacts
clean:
	find . -name \*.zip -delete
	find . -name \*.war -delete

download:
	mvn package

openam:
	docker build -t $(REPO)/$@:$(TAG) $@

openidm:
	docker build -t $(REPO)/$@:$(TAG) $@
	docker build -t $(REPO)/openidm-postgres openidm-postgres

opendj:
	docker build -t $(REPO)/$@:$(TAG) $@

openig:
	docker build -t $(REPO)/$@:$(TAG) $@

ssoadm:
	docker build -t $(REPO)/$@:$(TAG) $@

ssoconfig:
	docker build -t $(REPO)/$@:$(TAG) $@

resty:
	docker build -t $(REPO)/$@:$(TAG) $@
ifdef PUSH
	docker push $(REPO)/$@:$(TAG)
endif


# Note: Apache agent is not available via maven.
# todo: get a stable download location
apache-agent:
	curl "http://download.forgerock.org/downloads/openam/webagents/nightly/Linux/Apache_v24_Linux_64bit_4.0.0-SNAPSHOT.zip" -o apache-agent/agent.zip
	docker build -t $(REPO)/$@:$(TAG) $@
