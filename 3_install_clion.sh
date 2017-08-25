

if [[ `id -u` == 0 ]]; then
    error="Do not run as root, otherwise the script cannot install opencv properly."
    zenity --info --text=$error &
    echo $error
    exit
fi
user="$(whoami)"
cd "/home/$user"

sudo echo "installing clion and c++ compiler"
 
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
sh clion.sh &
echo "this window will now close."
zenity --info --text="You can register Clion using their website and a university email.\nYou may find the 'activation code' option the easiest to use."


