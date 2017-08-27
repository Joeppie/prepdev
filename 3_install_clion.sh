#This script installs clion by downloading the currently (aug 2017) package, unzipping it to /home/username/clion-2017.2.1 and then running the clion.sh.

if [[ `id -u` == 0 ]]; then
    error="Do not run as root, otherwise the script cannot install opencv properly."
    zenity --info --text=$error &
    echo $error
    exit
fi
user="$(whoami)"
cd "/home/$user"

#simple function that echoes and uses notification for messages.
function message() { 
    echo $@ 
    notify-send "$0" "$@" 
}

message "Downloading clion and instlling g++ if not installed."
sudo apt-get install g++
#cannot put name of exact clion version into variable; notice how extracted folder is named differently (caps)
wget https://download-cf.jetbrains.com/cpp/CLion-2017.2.1.tar.gz
tar zfx CLion-2017.2.1.tar.gz
rm CLion-2017.2.1.tar.gz
cd clion-2017.2.1/
chmod -R 0755 .
cd bin
message "clion has been installed, please configure it"
sh clion.sh &




