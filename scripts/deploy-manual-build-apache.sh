#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
mkdir demo-docker && cd demo-docker

# https://github.com/fedora-cloud/Fedora-Dockerfiles/blob/master/apache/Dockerfile

# Example: Web application
# Create a working directory with some content for a web server
mkdir demo-apache && cd demo-apache && echo 'sample apache container' > index.html


# Start the Dockerfile.fedora.apache with a FROM command to indicate the base image
echo 'FROM fedora:latest' >> Dockerfile.fedora.apache
# Updating dependencies, installing Apache and cleaning dnf caches to reduce container size
echo 'RUN dnf -y update && dnf -y install httpd && dnf clean all' >> Dockerfile.fedora.apache.fedora.httpd
# Creating placeholder file to be served by apache
echo 'RUN echo "Apache fedora container" >> /var/www/html/index.html' >> Dockerfile.fedora.apache
# open 80 port, the default one for HTTP for Apache server to listen on
echo 'EXPOSE 80' >> Dockerfile.fedora.apache
# Simple startup script to avoid some issues observed with container restart
echo 'ADD run-apache.sh /run-apache.sh' >> Dockerfile.fedora.apache
echo 'RUN chmod -v +x /run-apache.sh' >> Dockerfile.fedora.apache
echo 'CMD ["/run-apache.sh"]' >> Dockerfile.fedora.apache

stat Dockerfile.fedora.apache

# Build the image with a descriptive tag
 docker build --no-cache --rm  -t fedora:apache . --file Dockerfile.fedora.apache
# Run the container and publish the port
docker run -d -p 8080:80 --name apache --rm fedora:apache
# View the port information
docker port apache
# Access the web page from the host device
curl localhost:8080


echo "========================================================================================="
