FROM modulator:latest

MAINTAINER Fenglin Chen <f73chen@uwaterloo.ca>

# move in the yaml to build modulefiles from
COPY bwa_recipe.yaml /modulator/code/gsi/recipe.yaml

# build the modules and set folder / file permissions
RUN ./build-local-code /modulator/code/gsi/recipe.yaml --initsh /usr/share/modules/init/sh --output /modules && \
	find /modules -type d -exec chmod 777 {} \; && \
	find /modules -type f -exec chmod 777 {} \;

# create the user
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

# copy in the environment setup file
COPY .bashrc /home/ubuntu/.bashrc

# command on launch
CMD /bin/bash
