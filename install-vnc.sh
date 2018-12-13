#!/bin/bash

#          Install and configure VNC service
# Author : Jeffrey.Powell ( jffrypwll <at> googlemail <dot> com )
# Date   : Dec 2018

# Die on any errors

#set -e 

if [[ `whoami` != "root" ]]
then
  printf "\n\n Script must be run as root. \n\n"
  exit 1
fi

OS_VERSION=$(cat /etc/os-release | grep VERSION=)

case $OS_VERSION in

*jessie*)
  # Install for Raspbian Jessie
  printf "\n\nInstalling on raspbian Jessie."
  
  printf "\n\n Installation Complete. Some changes might require a reboot."
;;

*)
  # Unknown OS
  echo "Unknown OS $OS_VERSION"
  ;;
  
esac

printf "\n\n Installation Complete. Some changes might require a reboot. \n\n"
exit 1
