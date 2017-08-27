# prepdev
A set of bash scripts that prepare a linux (developed on mint 18.2) machine for developing against ceres, opencv and openMVG

This repo may be expanded to include sample projects that make use of the above libraries to provide a running start with developing new applications.

## Running the scripts
Usage:

Go to any directory (e.g. home) and use 

    git clone https://github.com/Joeppie/prepdev
    cd prepdev

If you are using a VMware machine start with 

    ./1_prepare.sh
This updates the apt-repository and install the latest vmware guest tools for smoother development.
    
Continue with:

    ./2_Install-ceres.sh	
    ./3_install_clion.sh	
    ./4_install_opencv_and_contrib.sh	
    ./5_install_openmvg.sh
This install Ceres, OpenCV, OpenCV_contrib, and openMVG and the respective requirements of each of these.

note: openMVG is installed into /home/joep/openMVG_Build/openMVG_install as per the instructions of the openMVG build.md instructions.

## After running the scripts

WIP: SET(OpenMVG_DIR "/home/joep/openMVG_Build/openMVG_install/share/openMVG/cmake") needs to be set before using find_package in the cmake that uses openMVG as a dependency.
However, to do that, the username needs to be dynamically inserted into the cmake file. Some other things are necessary there too.

## disclaimer
It could be that I accidentally messed the order of things to install, and that you may need to e.g. install clion before ceres.
If so, please let me know and I will try to fix it.

