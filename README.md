# sanei-printer-app

A dockerized printer application based on CUPS for Sanei® printers

***

## Supported printers

The following Sanei printers are fully supported

- SK1-21

The following Sanei printers have not been tested yet
- AL-58
- BL2-58
- BL-112
- SM1-21
- BLM-80
- SM2-41
- SM3-21
- SD1-31
- SD3-21
- SD3-22
- SK1-31
- SK1-41
- SK4-21
- SK4-31
- SK5-31
- SP1-21
- SP2-21
- SP3-21
- uTP-58
- SM4-21
- SM4-31

## How to use it

Using this printer application is pretty simple. Just follow the steps below in order to make it working on your system.

### Clone the repository

`git clone git@github.com:drcoccodrillus/sanei-printer-app.git`

### Build the image

`docker-compose up --build -d`

### Connect the printer

Connect your Sanei printer to your machine

### Initialize the printer app

`docker exec sanei-printers discovery`

### Check if your printer has been configured

`docker exec sanei-printers lpstat -t`

### Use your printer

`docker exec sanei-printers lp -d printer-name /printers/test.txt`

## To do

- [ ] Full support for AL-58
- [ ] Full support for BL2-58
- [ ] Full support for BL-112
- [ ] Full support for SM1-21
- [ ] Full support for BLM-80
- [ ] Full support for SM2-41
- [ ] Full support for SM3-21
- [ ] Full support for SD1-31
- [ ] Full support for SD3-21
- [ ] Full support for SD3-22
- [x] Full support for SK1-21
- [ ] Full support for SK1-31
- [ ] Full support for SK1-41
- [ ] Full support for SK1-211
- [ ] Full support for SK1-311
- [ ] Full support for SK4-21
- [ ] Full support for SK4-31
- [ ] Full support for SK5-31
- [ ] Full support for SP1-21
- [ ] Full support for SP2-21
- [ ] Full support for SP3-21
- [ ] Full support for uTP-58
- [ ] Full support for SM4-21
- [ ] Full support for SM4-31
- [ ] Automatic retrieving of printer device uri and printer setup

## Troubleshooting

Sometimes things simply go wrong. If you need to troubleshoot CUPS these are places you should look at:
- `/var/log/cups/access_log` - Lists all cupsd http1.1 server activity
- `/var/log/cups/error_log` - Lists detailed information of the printing process
- `/var/log/cups/page_log` - Echoes a new entry each time a print is successful
- `/var/spool/cups` - Location where the scheduler stores job files


The best way to get complete information from log files is to set `LogLevel` in `/etc/cups/cupsd.conf` as the following:

```
LogLevel debug
```

And then viewing the output from `/var/log/cups/error_log` like this:
```
tail -n 100 -f /var/log/cups/error_log
```

The `/var/spool/cups` location stores two types of files: control files starting with the letter "c" and data files starting with the letter "d". Control files are IPP messages based on the original IPP Print-Job or Create-Job messages, while data files are the original print files that were submitted for printing. There is one control file for every job known to the system and 0 or more data files for each job.

Control files are normally cleaned out after the 500th job is submitted, while data files are removed immediately after a job has successfully printed. Both behaviors can be configured.
