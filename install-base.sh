#!/bin/bash

RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
GREY=`tput setaf 7`

NC=`tput sgr0`

if [[ `whoami` != "root" ]]
then
  printf "\n\n${RED} Script must be run as root. ${NC}\n\n"
  exit 1
fi


ALIASES_FILE="/home/pi/.bash_aliases"

if [ -f "$ALIASES_FILE" ]
then
	printf "\n\nAliases already installed ... skipping ...\n\n"
else
	printf "\n\n${CYAN} Installing Aliases ${NC}\n\n"
cat > $ALIASES_FILE <<ALIASES
alias ll='ls -hal'
alias la='ls -A'
alias l='ls =CF'
ALIASES

chown pi:pi /home/pi/.bash_aliases
su -c "source /home/pi/.bashrc" pi

fi


THONNY_INSTALLED=$(which thonny)

if [[ "$THONNY_INSTALLED" == "" ]]
then
	printf "\n\nInstalling Thonny Editor\n\n"
	apt-get install python3-thonny-pi
else
	printf "\nThonny already installed ... skipping ...\n"
fi


VIM_INSTALLED=$(which vim)

if [[ "$VIM_INSTALLED" == "" ]]
then
  printf "\n\n Installing Vim ...\n"
  # Install VIM editor
  apt-get install vim -y
  # Set VIM as the default editor
  update-alternatives --set editor /usr/bin/vim.basic
  # Vim settings (colors, syntax highlighting, tab space, etc).
  chown pi:pi /home/pi/.vim
  mkdir -p /home/pi/.vim/colors
  chown pi:pi /home/pi/.vim/colors
  wget "http://www.vim.org/scripts/download_script.php?src_id=11157" -O /home/pi/.vim/colors/synic.vim
  chown pi:pi /home/pi/.vim/colors/synic.vim
  # Set VIM defaults
  cat > /home/pi/.vimrc <<VIM
:syntax on
:colorscheme synic
:set paste
:set softtabstop=2
:set tabstop=2
:set shiftwidth=2
:set expandtab
:set number
VIM
 chown pi:pi /home/pi/.vimrc
else
  printf "\n\nVim is already installed ... skipping ...\n"
fi

APACHE2_INSTALLED=$(which apache2)
if [[ "$APACHE2_INSTALLED" == "" ]]
then
	printf "\n\nInstalling Apache2\n\n"
	apt-get install apache2 -y
	update-rc.d apache2 enable
	a2dissite 000-default.conf
	
	if [ ! -d "/var/www/website" ]
	then
	      mkdir "/var/www/website"
	fi
	
	cat > /etc/apache2/sites-available/website.conf << VIRTUALHOST
<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/website
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
VIRTUALHOST

	cat > /var/www/website/index.html << WEBSITE
Hello World
WEBSITE

	a2ensite website.conf
	service apache2 restart
	
	
else
	printf "\nApache2 already installed ... skipping ...\n"
fi

PHP_INSTALLED=$(which php)
if [[ "$PHP_INSTALLED" == "" ]]
then
	printf "\n\nInstalling PHP\n\n"
	apt-get install php -y
else
	printf "\nPHP already installed ... skipping ...\n"
fi

MYSQL_INSTALLED=$(which mysql)
if [[ "$MYSQL_INSTALLED" == "" ]]
then
	printf "\n\nInstalling MYSQL\n\n"
	apt-get install mysql-server -y
else
	printf "\nMYSQL already installed ... skipping ...\n"
fi

PHPMYSQL_INSTALLED=$(find /var/lib/dpkg -name php*-mysql*)
if [[ "$PHPMYSQL_INSTALLED" == "" ]]
then
	printf "\n\nInstalling PHP MYSQL\n\n"
	apt-get install php-mysql -y
else
	printf "\nPHP MYSQL already installed ... skipping ...\n"
fi

PYMYSQL_INSTALLED=$(find /var/lib/dpkg -name python-mysql*)
if [[ "$PYMYSQL_INSTALLED" == "" ]]
then
	printf "\n\nInstalling PYTHON MYSQL\n\n"
	apt-get install python-mysqldb -y
else
	printf "\nPYTHON MYSQL already installed ... skipping ...\n"
fi




if [ ! -f "/etc/cron.d/ip_mon" ]
  then
    cat > /etc/cron.d/ip_mon << CRON
@reboot pi /usr/bin/python3 /home/pi/cron_scripts/ip_mon.py &
CRON
    service cron restart
fi

printf "\n\nInstallation Complete. Some changes might require a reboot. \n\n"
exit 1
