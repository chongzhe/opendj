# Note: Use the build.sh shell script to build docker images

.PHONY: clean download all


all:
	./build.sh -d

# Clean up any downloaded artifacts
clean:
	find . -name \*.zip -delete
	find . -name \*.war -delete

download:
	mvn package

# Note: Apache agent is not available via maven.
# todo: get a stable download location
apache-agent:
	curl "http://download.forgerock.org/downloads/openam/webagents/nightly/Linux/Apache_v24_Linux_64bit_4.0.0-SNAPSHOT.zip" -o apache-agent/agent.zip

