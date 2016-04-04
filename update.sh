##################################################################################################################################################
# Version 1.2
# Check if root
        if [ "$(whoami)" != "root" ]; then
        echo
        echo -e "\e[31mSorry, you are not root.\n\e[0mYou must type: \e[36msudo \e[0mbash /var/scripts/update.sh"
        echo
        exit 1
fi

# Upgrade and install
apt-get update && apt-get upgrade -y && apt-get -f install -y
apt-get install rsyslog systemd module-init-tools -y
dpkg --configure --pending

# Install rpi-update
echo "deb http://archive.raspberrypi.org/debian/ jessie main" > /etc/apt/sources.list
wget "http://archive.raspberrypi.org/debian/raspberrypi.gpg.key"
apt-key add raspberrypi.gpg.key
apt-get update
apt-get install libraspberrypi-bin -y
curl -L --output /usr/bin/rpi-update https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update && sudo chmod +x /usr/bin/rpi-update
echo "rpi-update" >> /etc/cron.weekly/rpi-update.sh
rpi-update
chmod 750 /etc/cron.daily/rpi-update.sh

# Get the latest login screen
rm /var/scripts/techandme.sh
wget https://github.com/ezraholm50/BerryCloud/raw/master/techandme.sh -P /var/scripts/
chown ocadmin:ocadmin /var/scripts/techandme.sh
chmod 750 /var/scripts/techandme.sh

# Cleanup
rm /var/scripts/update.sh
apt-get autoclean -y && apt-get autoremove -y && apt-get update && apt-get upgrade -y
reboot

##################################################################################################################################################
##Version 1.3

exit 0
