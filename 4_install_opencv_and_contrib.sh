#!/bin/bash

#this script installs opencv and opencv_contrib by cloning the master repositories off of Github.

#simple function that echoes and uses notification for messages.
function message() { 
    echo $@ 
    notify-send "$0" "$@" 
}



if [[ `id -u` == 0 ]]; then
    error="Do not run as root, otherwise the script cannot install opencv properly."
    zenity --info --text=$error
    echo $error
    exit
fi

user="$(whoami)"
cd "/home/$user"
sudo echo "installing OpenCV, Opencv_contrib and dependencies"


sleep 2
# CMake
sudo apt-get -y install cmake                               # google-glog + gflags
sudo apt-get -y install libgoogle-glog-dev
sudo apt-get -y install libatlas-base-dev                   # BLAS & LAPACK
sudo apt-get -y install libeigen3-dev                       # Eigen3
sudo apt-get -y install libsuitesparse-dev
sudo apt-get -y install libprotobuf-dev                     #seemingly required ; linked by target "opencv_dnn_modern" in directory 
sudo apt-get -y install libgtkglext1 libgtkglext1-dev       #for open gl support.
sudo apt-get -y install libvtk5-dev                         #visualization tooklkit.
sudo apt-get -y install libblas-dev liblapack-dev           #(note that first one is NOT liblas, it's libblas.)
sudo apt-get -y install build-essential libgtk2.0-dev       #required for UI; opencv currently uses gtk2+
sudo apt-get -y install libgdal-dev                         #gdal
sudo apt-get -y install liblapack-dev                       #lapack
sudo apt-get -y install doxygen                             #doxygen

message="packages installed,cloning repo for opencv and contrib."
notify-send $message
echo $message

git clone --recursive https://github.com/opencv/opencv.git
git clone --recursive https://github.com/opencv/opencv_contrib.git
cd opencv
mkdir build
cd build


extraModules="/home/$user/opencv_contrib/modules"

echo "open-cv contrib modules located in: '$extraModules'"

echo "creating build folder in /home/$user/opencv ..."
cd "/home/$user/opencv"
mkdir -p build
cd build
#arguments spread on multiple lines for clarity.
cmakeArguments="-D CMAKE_BUILD_TYPE=Release"\
" -D CMAKE_INSTALL_PREFIX=/usr/local"\
" -D OPENCV_EXTRA_MODULES_PATH=$extraModules"\
" -D BUILD_DOCS=ON -D BUILD_EXAMPLES=ON -D WITH_OPENGL=ON -D BUILD_DOCS=ON "\
" -D WITH_GDAL=ON -D WITH_OPENMP=ON -D WITH_LAPACK=ON -D ENABLE_CXX11=ON"\
" .. " #The location of the sources (one folder up from build)

cores=$(grep -c ^processor /proc/cpuinfo)

cmake $cmakeArguments && make -j$cores && sudo make install

cd ~/opencv/build/doc/
make -j$cores html_docs

