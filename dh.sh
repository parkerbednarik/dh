#!/bin/bash
# Colors!
P='\033[0m' #Plain
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

drive_count=$(lsblk -d -o NAME | grep -v -E "NAME|loop" | wc -l)
echo -e "Number of physical drives (excluding loop devices):${YELLOW} $drive_count"

for drive in $(smartctl --scan | grep "/dev/bus/0 -d" | awk '{print $3}'); do
        echo -e "${RED}-> Gathering information for drive $drive${P}"
        smartctl -a /dev/bus/0 -d $drive | grep -i -e serial -e 'smart health' -e 'temperature' -e protocol -e defect
        smartctl -a /dev/bus/0 -d $drive | grep -A 5 uncorrected
done

