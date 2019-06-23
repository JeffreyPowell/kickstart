#!/bin/bash

wget -r -O /home/pi/offgrid/cron/poll-adc.py "https://raw.githubusercontent.com/JeffreyPowell/offgrid/master/cron/poll-adc.py"

chmod u+x /home/pi/offgrid/cron/poll-adc.py
chown pi:pi /home/pi/offgrid/cron/poll-adc.py

wget -r -O /home/pi/offgrid/cron/ABElectronics_ADCPi.py "https://raw.githubusercontent.com/JeffreyPowell/offgrid/master/cron/ABElectronics_ADCPi.py"

chmod u+x /home/pi/offgrid/cron/ABElectronics_ADCPi.py
chown pi:pi /home/pi/offgrid/cron/ABElectronics_ADCPi.py

wget -r -O /home/pi/offgrid/cron/ABElectronics_ADCPi.pyc "https://raw.githubusercontent.com/JeffreyPowell/offgrid/master/cron/ABElectronics_ADCPi.pyc"

chmod u+x /home/pi/offgrid/cron/ABElectronics_ADCPi.pyc
chown pi:pi /home/pi/offgrid/cron/ABElectronics_ADCPi.pyc

python /home/pi/Desktop/send_gmail.py -t "jffrypwll@gmail.com" -s "update has run"
