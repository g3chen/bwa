FROM modulator:latest

MAINTAINER Fenglin Chen <f73chen@uwaterloo.ca>

# packages should already be set up in modulator:latest
	# USER root

# move in the yaml to build modulefiles from
COPY bwa_recipe.yaml /modulator/code/gsi/recipe.yaml

# build the modules and set folder / file permissions
RUN ./build-local-code /modulator/code/gsi/recipe.yaml --initsh /usr/share/modules/init/sh --output /modules && \
	find /modules -type d -exec chmod 777 {} \; && \
	find /modules -type f -exec chmod 777 {} \;

# add the user
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

# copy the setup file to load the modules at startup
# cromwell doesn't seem to load .bashrc, will manually load instead
COPY .bashrc /home/ubuntu/.bashrc

# adding environment variables for the tools
ENV BWA_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/bwa-0.7.12"
ENV SAMTOOLS_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/samtools-1.9"
ENV HTSLIB_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9"
ENV SLICER_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/slicer-0.3.0"
ENV PYTHON_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/python-2.7"
ENV CUTADAPT_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/cutadapt-1.8.3"
ENV PATH="/modules/gsi/modulator/sw/Ubuntu18.04/cutadapt-1.8.3/bin:/modules/gsi/modulator/sw/Ubuntu18.04/python-2.7/bin:/modules/gsi/modulator/sw/Ubuntu18.04/samtools-1.9/bin:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/bin:/modules/gsi/modulator/sw/Ubuntu18.04/slicer-0.3.0/bin:/modules/gsi/modulator/sw/Ubuntu18.04/bwa-0.7.12/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# ENV MANPATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-2.7/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/samtools-1.9/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/share/man"
# ENV PYTHONPATH="/modules/gsi/modulator/sw/Ubuntu18.04/cutadapt-1.8.3/lib/python2.7/site-packages:/modules/gsi/modulator/sw/Ubuntu18.04/python-2.7/lib/python2.7/site-packages"
# ENV LD_LIBRARY_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/cutadapt-1.8.3/lib:/modules/gsi/modulator/sw/Ubuntu18.04/python-2.7/lib:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib"
# ENV PKG_CONFIG_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-2.7/lib/pkgconfig:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib/pkgconfig"

# command on launch
CMD /bin/bash
