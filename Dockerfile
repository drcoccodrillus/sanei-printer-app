FROM ubuntu:22.04 AS base

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y \
    apt-utils \
    usbutils \
    cups \
    libcups2-dev \
    libcupsimage2-dev

RUN apt-get autoremove -y && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt

COPY ./test-files /printers
COPY ./drivers /printers/drivers
COPY ./bin /printers/bin

#Drivers for Sanei SK1-21
WORKDIR /printers/drivers/sk1_21
RUN chmod 755 x86_64/rastertosanei
RUN cp -f x86_64/rastertosanei /usr/lib/cups/filter
RUN cp -f x86_64/sanei_SK1_21.ppd /usr/share/cups/model

#Drivers for Sanei SK1-31
WORKDIR /printers/drivers/sk1_31
RUN chmod 755 x86_64/rastertosanei
RUN cp -f x86_64/rastertosanei /usr/lib/cups/filter
RUN cp -f x86_64/sanei_SK1_31.ppd /usr/share/cups/model

RUN rm -rf /printers/drivers

WORKDIR /printers/bin
RUN chmod +x start.sh
RUN ln -s /printers/bin/start.sh /bin/discovery

ENTRYPOINT ["/usr/sbin/cupsd", "-f"]
