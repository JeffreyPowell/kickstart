#!/bin/bash

wget -r -O /home/pi/offgrid/cron/poll-adc.py "https://raw.githubusercontent.com/JeffreyPowell/offgrid/master/cron/poll-adc.py"

python /home/pi/Desktop/send_gmail.py -t "jffrypwll@gmail.com" -s "update has run"
