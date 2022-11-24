#!/bin/zsh

# run only as root
if [ "$EUID" -ne 0 ]
    then echo "The updater script must be run as root user. Please use 'sudo updater'."
    exit
fi

# confirm updating

echo -e "\n\n##########################################################\nconfirm updating\n##########################################################\n"
if [[ "$1" == "-y" ]]; then
    echo "confirmation bypassed with '-y' argument, continuing..."
else
    echo "ARE YOU SURE YOU WANT TO UPDATE --ALL-- SYSTEM RESSOURCES: Y/n"
    read key
    if [[ "$key" == "y" ]] || [[ "$key" == "Y" ]] || [[ "$key" == "" ]]; then
        if [[ "$key" == "" ]]; then
            echo -n "Y"
        fi
        echo "continuing..."
    else
        echo -e "\nno confirmation recieved, aborting..."
	exit
    fi
fi

echo -e "\n\n##########################################################\nsetting up the updater-script\n##########################################################\n"
echo -e "running as user $(whoami) with UID=$UID\nPATH=$PATH"
mkdir -p /tmp/update-script
cd /tmp/update-script
echo "working dir is now: $(pwd)"

# starting updates
echo -e "\n\n##########################################################\nstarting updates\n##########################################################\n"
echo -e "\n\n##########################################################\nupdating apt packages...\n##########################################################\n"
apt update -y && apt upgrade -y && apt autoremove -y

echo -e "\n\n##########################################################\nupdating flatpaks for user plex...\n##########################################################\n"
sudo -u plex flatpak update -y

echo -e "\n\n##########################################################\nupdating flatpaks for user root...\n##########################################################\n"
flatpak update -y

# custom updates
echo -e "\n\n##########################################################\nstarting custom updates\n##########################################################\n"

# bitwig
echo -e "\n\n##########################################################\nmaking custom updates: bitwig-studio...\n##########################################################\n"

wget -O bitwig.deb https://downloads.bitwig.com/4.3.4/bitwig-studio-4.3.4.deb
apt install ./bitwig.deb -y
rm bitwig.deb

# DroidCam
# requires confirmation, sucks.
# FIXME
#echo -e "\n\n##########################################################\nmaking custom updates: DroidCam...\n##########################################################\n"
#
#wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.2.zip
## sha1sum: d1038e6d62cac6f60b0dd8caa8d5849c79065a7b
#unzip droidcam_latest.zip -d droidcam
#cd droidcam && ./install-client
#./install-video && ./install-sound

# oh my zsh
echo -e "\n\n##########################################################\nmaking custom updates: Oh My Zsh...\n##########################################################\n"

echo -e "\n\n##########################################################\nmaking custom updates: Oh My Zsh - user plex...\n##########################################################\n"
#zsh /root/.zsh/tools/upgrade.sh
cd /root/.zsh/tools/
echo "working dir is now: $(pwd)"
#echo "files here are $(ls)"
./upgrade.sh

echo -e "\n\n##########################################################\nmaking custom updates: Oh My Zsh - user root...\n##########################################################\n"
#zsh /home/plex/.oh-my-zsh/tools/upgrade.sh
cd /home/plex/.oh-my-zsh/tools/
echo "working dir is now: $(pwd)"
#echo "files here are $(ls)"
./upgrade.sh

echo -e "\n returning to standard working directory..."
mkdir -p /tmp/update-script
cd /tmp/update-script
echo "working dir is now: $(pwd)"

# npm
echo -e "\n\n##########################################################\nmaking custom updates: npm...\n##########################################################\n"
npm install -g npm

# firmware update notice
echo -e "\n\n##########################################################\nNotifiers\n##########################################################\n"

echo -e "\n\n##########################################################\nNotifiers: Firmware updates\n##########################################################\n"
fwupdmgr get-upgrades

echo -e "\n\n##########################################################\nfinished updater script.\n##########################################################\n"
echo "You may want to look into the update-manager of Cinnamon to update Cinnamon-desklets, i havent found a CLI tool to update these."
