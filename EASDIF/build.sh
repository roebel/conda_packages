#! /bin/bash


echo $CONDA_NPY
mkdir -p build_easdif
cd build_easdif
if [ $(uname) = "Linux" ]; then 
    # avoid c++17 because EASDIF does not work
    export CXXFLAGS=$(echo $CXXFLAGS| sed -e s/c++17/c++11/g)    
fi
cmake ../EASDIF_SDIF -DPYTHON:PATH=${PYTHON}3 -DEASDIF_DO_PYTHON:bool=on

make pythonswig -j3
make install_python_easdif_module_globally
#cd ..
#rm -f *~
#rm -rf EASDIF_SDIF
#rm -rf build_easdif
