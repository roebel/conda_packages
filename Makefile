SHELL=/bin/bash

NUMPY?=NUMPY_HAS_TO_BE_SET_ON_COMMANDLINE
NUMPYSTR=np$(shell echo $(NUMPY) | sed -e s/[.]//g)

conda_path=$(shell type -p conda)
ifeq ($(shell uname),Linux)
	conda_build_dir=$(shell  dirname $$(dirname $(conda_path)))/conda-bld/linux-64
else
	conda_build_dir=$(shell dirname $$(dirname $(conda_path)))/conda-bld/osx-64
endif

build_all:  build_easdif build_pyfftw build_pysndfile 
upload_all: upload_easdif upload_pyfftw upload_pysndfile

# only used for initialisation when compilation has already been done manually
create_links:
	@mkdir -p last_builds
	@file=$(shell ls -lrt $(conda_build_dir)/*easdif*$(NUMPYSTR)* 2>/dev/null |tail -1| rev| cut -f1 -d" "| rev); if [ "$$file" = "" ]; then rm -f last_builds/easdif_$(NUMPYSTR); else ln -sf  $$file last_builds/easdif_$(NUMPYSTR); echo updated to $$file; fi
	@file=$(shell ls -lrt $(conda_build_dir)/*pysndfile*$(NUMPYSTR)* 2>/dev/null |tail -1| rev| cut -f1 -d" "| rev); if [  "$$file" = "" ]; then rm -f last_builds/pysndfile_$(NUMPYSTR); else  ln -sf $$file last_builds/pysndfile_$(NUMPYSTR); echo updated to $$file;  fi
	@file=$(shell ls -lrt $(conda_build_dir)/*pyfftw*$(NUMPYSTR)* 2>/dev/null |tail -1| rev| cut -f1 -d" "| rev); if [ "$$file" = "" ]; then rm -f last_builds/pyfftw_$(NUMPYSTR);  else ln -sf $$file last_builds/pyfftw_$(NUMPYSTR); echo updated to $$file; fi


upload_pysndfile: build_pysndfile
	anaconda upload --force $$(readlink last_builds/pysndfile_$(NUMPYSTR))

upload_easdif: build_easdif
	anaconda upload --force $$(readlink last_builds/easdif_$(NUMPYSTR))

upload_pyfftw: build_pyfftw
	anaconda upload --force $$(readlink last_builds/pyfftw_$(NUMPYSTR))

build_pysndfile: last_builds/pysndfile_$(NUMPYSTR)
last_builds/pysndfile_$(NUMPYSTR): pysndfile/meta.yaml pysndfile/build.sh
	conda build --numpy=$(NUMPY) pysndfile
	@mkdir -p last_builds
	@file=$$(ls -lrt $(conda_build_dir)/*pysndfile*$(NUMPYSTR)* 2>/dev/null |tail -1| rev| cut -f1 -d" "| rev); if [  "$$file" = "" ]; then rm -f last_builds/pysndfile_$(NUMPYSTR); else  ln -sf $$file last_builds/pysndfile_$(NUMPYSTR); echo updated to $$file;  fi

build_easdif: last_builds/easdif_$(NUMPYSTR) 
last_builds/easdif_$(NUMPYSTR): EASDIF/meta.yaml EASDIF/build.sh
	conda build --numpy=$(NUMPY) EASDIF 
	@mkdir -p last_builds
	@file=$$(ls -lrt $(conda_build_dir)/*easdif*$(NUMPYSTR)* 2>/dev/null |tail -1| rev| cut -f1 -d" "| rev); if [ "$$file" = "" ]; then rm -f last_builds/easdif_$(NUMPYSTR); else ln -sf  $$file last_builds/easdif_$(NUMPYSTR); echo updated to $$file; fi

build_pyfftw: last_builds/pyfftw_$(NUMPYSTR)
last_builds/pyfftw_$(NUMPYSTR): pyfftw/meta.yaml pyfftw/build.sh
	conda build --numpy=$(NUMPY) pyfftw
	@mkdir -p last_builds
	@file=$$(ls -lrt $(conda_build_dir)/*pyfftw*$(NUMPYSTR)* 2>/dev/null |tail -1| rev| cut -f1 -d" "| rev); if [ "$$file" = "" ]; then rm -f last_builds/pyfftw_$(NUMPYSTR);  else ln -sf $$file last_builds/pyfftw_$(NUMPYSTR); echo updated to $$file; fi


