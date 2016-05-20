# If you edit this with an IDE beware of converting tabs to spaces (Make wants tabs)
.PHONY: clean download

all:
	./build.sh -d -p foo

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

