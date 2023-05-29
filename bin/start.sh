#!/bin/bash

sleep 5

SEARCH_SANEI_SK1_21=$(lsusb | awk '{print $6}' | grep "10c5:0009")
SEARCH_SANEI_SK1_V31=$(lsusb | awk '{print $6}' | grep "10c5:0007")

for s in $(lpstat -v | grep -v "/dev/null" | awk '{print $3}' | sed s/://g); do
    /usr/sbin/cupsdisable $s
done

sleep 5

if [ "$SEARCH_SANEI_SK1_21" = "10c5:0009" ]; then
    /usr/sbin/lpadmin -x gprinter
    /usr/sbin/lpadmin -p gprinter -v usb://SANEI/SK1-21%20Series
    /usr/sbin/lpadmin -p gprinter -m sanei_SK1_21.ppd
    /usr/sbin/lpadmin -p gprinter -o printer-is-shared=true
    /usr/sbin/lpadmin -d gprinter
    /usr/sbin/cupsenable gprinter
    /usr/sbin/cupsaccept gprinter
fi

if [ "$SEARCH_SANEI_SK1_V31" = "10c5:0007" ]; then
    /usr/sbin/lpadmin -x gprinter
    /usr/sbin/lpadmin -p gprinter -v usb://SANEI/SK%20Series
    /usr/sbin/lpadmin -p gprinter -m sanei_SK1_31.ppd
    /usr/sbin/lpadmin -p gprinter -o printer-is-shared=true
    /usr/sbin/lpadmin -d gprinter
    /usr/sbin/cupsenable gprinter
    /usr/sbin/cupsaccept gprinter
fi
