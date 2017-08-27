#!/bin/bash

#simple function that echoes and uses notification for messages.
function message() { 
    echo $@ 
    notify-send "$0" "$@" 
}



if [[ `id -u` == 0 ]]; then
    error="Do not run as root, otherwise the script cannot install opencv properly."
    zenity --info --text=$error &
    echo $error
    exit
fi
user="$(whoami)"
cd "/home/$user"
message "installing ceres and dependencies"

#determine amount of cores ideal for building.
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

#string together the set of dependent commands; && only lets them execute if the previous one was succesful
cmake ../ceres-solver && make -j$cores && sudo make install && message "Succesfully installed ceres. The unittests will now run, but you can run the other scripts"

make test 









