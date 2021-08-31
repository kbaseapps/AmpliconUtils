FROM kbase/sdkbase2:python
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

RUN apt-get update && apt-get install -y wget git build-essential make zlib1g-dev

RUN conda update --all

RUN conda create -n deblurenv python=3.5 numpy

RUN /bin/bash -c "source activate deblurenv \
    && conda install -c bioconda -c biocore "VSEARCH=2.7.0" MAFFT=7.310 SortMeRNA=2.0 biom-format deblur"

RUN conda install -c conda-forge r-base

COPY ./dada2_installation_scripts.R /kb/module/dada2_installation_scripts.R
RUN chmod -R a+rw /kb/module

RUN Rscript --vanilla /kb/module/dada2_installation_scripts.R

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

WORKDIR /kb/module

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]


# -----------------------------------------
