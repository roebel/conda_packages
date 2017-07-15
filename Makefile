SHELL=/bin/bash

NUMPY?=NUMPY_HAS_TO_BE_SET_ON_COMMANDLINE
NUMPYSTR=np$(shell echo $(NUMPY) | sed -e s/[.]//g)

conda_path=$(shell type -p conda)
conda_build_dir=$(shell dirname $(conda_path))/../conda-bld/linux-64

build_all: create_links build_easdif build_pyfftw build_pysndfile
upload_all: create_links upload_easdif upload_pyfftw upload_pysndfile

create_links:
	@mkdir -p last_builds
	@file=$(shell ls -lrt $(conda_build_dir)/*pysndfile*$(NUMPYSTR)*|tail -1| rev| cut -f1 -d" "| rev); if [ -f $$file ]; then ln -sf $$file last_builds/pysndfile_$(NUMPYSTR); echo updated to $$file; else rm -f last_builds/pysndfile_$(NUMPYSTR); fi
	@file=$(shell ls -lrt $(conda_build_dir)/*easdif*$(NUMPYSTR)*|tail -1| rev| cut -f1 -d" "| rev); if [ -f $$file ]; then ln -sf  $$file last_builds/easdif_$(NUMPYSTR); echo updated to $$file; else rm -f last_builds/easdif_$(NUMPYSTR); fi
	@file=$(shell ls -lrt $(conda_build_dir)/*pyfftw*$(NUMPYSTR)*|tail -1| rev| cut -f1 -d" "| rev); if [ -f $$file ]; then ln -sf $$file last_builds/pyfftw_$(NUMPYSTR); echo updated to $$file;  else rm -f last_builds/pyfftw_$(NUMPYSTR); fi


upload_pysndfile: build_pysndfile
	anaconda upload $(shell readlink last_builds/pysndfile_$(NUMPYSTR))

upload_easdif: build_easdif
	anaconda upload $(shell readlink last_builds/easdif_$(NUMPYSTR))

upload_pyfftw: build_pyfftw
	anaconda upload $(shell readlink last_builds/pyfftw_$(NUMPYSTR))

build_pysndfile: last_builds/pysndfile_$(NUMPYSTR)
last_builds/pysndfile_$(NUMPYSTR): pysndfile/meta.yaml pysndfile/build.sh
	echo conda build --numpy=$(NUMPY) pysndfile

build_easdif: last_builds/easdif_$(NUMPYSTR) create_links
last_builds/easdif_$(NUMPYSTR): EASDIF/meta.yaml EASDIF/build.sh
	echo conda build --numpy=$(NUMPY) EASDIF 

build_pyfftw: last_builds/pyfftw_$(NUMPYSTR)
last_builds/pyfftw_$(NUMPYSTR): pyfftw/meta.yaml pyfftw/build.sh
	echo conda build --numpy=$(NUMPY) pyfftw



