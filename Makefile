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
