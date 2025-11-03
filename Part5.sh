#/bin/bash

#donner une IP statique a ma VM
sudo nano /etc/netplan/*.yaml
sudo netplan apply


#Restreindre avec AppArmor

sudo aa-status
sudo aa-enforce /etc/apparmor.d/usr.sbin.apache2

#Faire en sorte que appache se lance que demarrage

sudo systemctl enable apache2