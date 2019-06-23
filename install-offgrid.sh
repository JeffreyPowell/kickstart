#!/bin/bash

#set -e 
clear

if [[ `whoami` != "root" ]]
then
  printf "\n\n Script must be run as root. \n\n"
  exit 1
fi


ENABLE_W1=$( cat /boot/config.txt | grep '^dtoverlay=w1-gpio$' )
if [[ $ENABLE_W1 == "" ]]
then
  echo "dtoverlay=w1-gpio" >> /boot/config.txt
  
  ENABLE_W1=$( cat /boot/config.txt | grep '^dtoverlay=w1-gpio$' )
  if [[ $ENABLE_W1 == "" ]]
  then  
    printf "\n\n EXITING : Unable to write to boot config. \n\n"
    exit 1
  fi
  apt-get update -y
  printf "\n\n REBOOT : Reeboot required to enable one wire module.\n\n"
  shutdown -r +1
else
  printf "\n One wire module enabled. \n"
  
  modprobe w1-gpio
  modprobe w1-therm
  
  printf "\n w1_gpio and w1_therm modules enabled. \n"
fi
