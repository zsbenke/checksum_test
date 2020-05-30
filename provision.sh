#!/usr/bin/env bash
echo "Increasing the amount of inotify watchers..."
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

echo "Refreshing packages..."
sudo apt-get -y update

echo "Installing default packages..."
sudo apt-get -y install avahi-daemon avahi-dnsconfd avahi-discover avahi-utils apt-transport-https ca-certificates curl software-properties-common
sudo sed -i 's/#deny-interfaces=eth1/deny-interfaces=docker0/g' /etc/avahi/avahi-daemon.conf
sudo sed -i 's/#publish-aaaa-on-ipv4=yes/publish-aaaa-on-ipv4=no/g' /etc/avahi/avahi-daemon.conf
sudo sed -i 's/use-ipv6=yes/use-ipv6=no/g' /etc/avahi/avahi-daemon.conf
sudo cp /usr/share/doc/avahi-daemon/examples/ssh.service /etc/avahi/services/.
sudo service avahi-daemon restart
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt-get -y update
sudo apt-get install -y docker-ce=18.06.3~ce~3-0~ubuntu
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
