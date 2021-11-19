#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
mkdir demo-docker && cd demo-docker

# Example: Web application
# Create a working directory with some content for a web server
mkdir demo-httpd && cd demo-httpd && echo 'sample container' > index.html

# https://docs.fedoraproject.org/en-US/iot/build-docker/
# Start the Dockerfile.fedora.httpd with a FROM command to indicate the base image
echo 'FROM fedora:latest' >> Dockerfile.fedora.httpd
# update the image and add any application and utilities
echo 'RUN dnf -y update && dnf -y install httpd git  && dnf clean all' >> Dockerfile.fedora.httpd.fedora.httpd
# Copy to the sample index.html file into the container
echo 'COPY index.html /var/www/html/index.html' >> Dockerfile.fedora.httpd
# what ports are available to publish
echo 'EXPOSE 80' >> Dockerfile.fedora.httpd
# Specify the command to run when the container starts
echo 'ENTRYPOINT /usr/sbin/httpd -DFOREGROUND' >> Dockerfile.fedora.httpd

stat Dockerfile.fedora.httpd

# Build the image with a descriptive tag
 docker build --no-cache --rm  -t fedora:httpd . --file Dockerfile.fedora.httpd
# Run the container and publish the port
docker run -p 8080:80 --name httpd --rm fedora:httpd
# View the port information
docker port httpd
# Access the web page from the host device
curl localhost:8080


echo "========================================================================================="
