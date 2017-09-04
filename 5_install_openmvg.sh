#!/bin/bash
if [[ `id -u` == 0 ]]; then
    error="Do not run as root, otherwise the script cannot install opencv properly."
    zenity --info --text=$error
    echo $error
    exit
fi
user="$(whoami)"
cd "/home/$user"

cores=$(grep -c ^processor /proc/cpuinfo)


if [ $1 = "noclone" ]; then
    echo "noclone specified, not cloning git directory to openMVG directory in home, assuming it is there already"
else
    message="Downloading git repo for openMVG."
    echo $message
    notify-send "Open MVG Installation" "$message"
    git clone --recursive https://github.com/openMVG/openMVG.git
fi

    
message="installing openMVG dependencies, enter sudo password if necessary."
echo $message
notify-send "Open MVG Installation" "$message"
sudo apt-get -y install libpng-dev libjpeg-dev libtiff-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev
sudo apt-get -y install graphviz
cd openMVG/
ls
cd ..
mkdir openMVG_Build
ls
cd openMVG_Build/
ls
mkdir openMVG_install
message="Installing cmake and performing build."
echo $message
notify-send "Open MVG Installation" "$message"

sudo apt -y install cmake

#warning: the installation path must be identical to openMVG_build, 
#otherwise the cmake find script fails, looking for the include folder directly under openMVG/Build.
cmakearguments="cmake -D CMAKE_INSTALL_PREFIX:STRING=/home/$user/openMVG_Build/openMVG_install"\
" -DCMAKE_BUILD_TYPE=RELEASE"\
" -DOpenMVG_BUILD_TESTS=ON"\
" -D OpenMVG_BUILD_EXAMPLES=ON . ../openMVG/src/"

echo "running 'cmake $cmakearguments'"
cmake $cmakearguments

make -j$cores

message="Installing Open MVG.."
echo $message
notify-send "Open MVG Installation" "$message"

sudo make install
read -p "Press enter to close terminal."
