

if [[ `id -u` == 0 ]]; then
    error="Do not run as root, otherwise the script cannot install opencv properly."
    zenity --info --text=$error &
    echo $error
    exit
fi
user="$(whoami)"
sudo cd "/home/$user"

echo "installing clion and c++ compiler"
 
sudo apt-get install g++
#cannot put name of exact clion version into variable; notice how extracted folder is named differently (caps)
wget https://download-cf.jetbrains.com/cpp/CLion-2017.2.1.tar.gz
tar zfx CLion-2017.2.1.tar.gz
rm CLion-2017.2.1.tar.gz
cd clion-2017.2.1/
ls
chmod -R 0755 .
ls
cd bin
ls


zenity --info --text="Register clion, (activation code from site is easiest) and after doing that, close it to avoid accidentally closing clion and its "
read -p "Please Copy text above, then press enter to close and start clion installer"
sh clion.sh &

