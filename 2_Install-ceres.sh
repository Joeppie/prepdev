#!/bin/bash


if [[ `id -u` == 0 ]]; then
    error="Do not run as root, otherwise the script cannot install opencv properly."
    zenity --info --text=$error &
    echo $error
    exit
fi
user="$(whoami)"
sudo cd "/home/$user"

cores=$(grep -c ^processor /proc/cpuinfo)

git clone --recursive https://ceres-solver.googlesource.com/ceres-solver

#ensure a c++ compiler exists.
sudo apt-get -y install g++
# CMake
sudo apt-get -y install cmake
# google-glog + gflags
sudo apt-get -y install libgoogle-glog-dev
# BLAS & LAPACK
sudo apt-get -y install libatlas-base-dev
# Eigen3
sudo apt-get -y install libeigen3-dev
# SuiteSparse and CXSparse (optional)
# - If you want to build Ceres as a *static* library (the default)
#   you can use the SuiteSparse package in the main Ubuntu package
#   repository:
sudo apt-get -y install libsuitesparse-dev


mkdir ceres-bin
cd ceres-bin
cmake ../ceres-solver #pathname corresponds to cloned repository.
make -j$cores #number of cores to build on;ideal performance is equal to number of logical cores; this script automatically sets that
make test
# Optionally install Ceres, it can also be exported using CMake which
# allows Ceres to be used without requiring installation, see the documentation
# for the EXPORT_BUILD_DIR option for more information.
sudo make install









