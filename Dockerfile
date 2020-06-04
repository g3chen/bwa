FROM modulator:latest

MAINTAINER Fenglin Chen <f73chen@uwaterloo.ca>

# packages should already be set up in modulator:latest
USER root

# move in the yaml to build modulefiles from
COPY no_python_cutadapt_bwa_recipe.yaml /modulator/code/gsi/recipe.yaml

# build the modules and set folder / file permissions
RUN ./build-local-code /modulator/code/gsi/recipe.yaml --initsh /usr/share/modules/init/sh --output /modules && \
	find /modules -type d -exec chmod 755 {} \; && \
	find /modules -type f -exec chmod 644 {} \;

# load the modulefiles
RUN /bin/bash -c "source /usr/share/modules/init/bash && \
	module use /modules/gsi/modulator/modulefiles/Ubuntu18.04 && \
	module load bwa/0.7.12 && \
	module load slicer/0.3.0 && \
	module load htslib/1.9 && \
	module load samtools/1.9 && \
	whereis bwa"

RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

#CMD /bin/bash
#CMD ["whereis", "samtools"]
CMD /bin/bash -c "source /usr/share/modules/init/bash"
#        module use /modules/gsi/modulator/modulefiles/Ubuntu18.04 && \ module avail"
#        module load bwa/0.7.12 && \
#        module load slicer/0.3.0 && \
#        module load htslib/1.9 && \
#        module load samtools/1.9 && \
#        whereis samtools"
