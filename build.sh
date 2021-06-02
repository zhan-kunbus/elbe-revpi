#!/bin/bash

sudo echo

if [ "1" != "$(mount | grep -c /mnt/wshare)" ]; then
	sudo mkdir -p /mnt/wshare
	sudo mount.cifs -o username=z.han,domain=KUNBUS //192.168.181.197/share/Entwickler/Simon /mnt/wshare
fi

git clean -f

BDIR=$(elbe control create_project)

elbe control set_xml "$BDIR" ./pre-build.xml
elbe control build "$BDIR"
elbe control wait_busy "$BDIR"

elbe control set_xml "$BDIR" ./armhf-revpi.xml
elbe control build "$BDIR"
elbe control wait_busy "$BDIR"

elbe control get_file "$BDIR" armhf-revpi.img.tar.gz
elbe control get_file "$BDIR" log.txt

sudo mv armhf-revpi.img.tar.gz "/mnt/wshare/elbe-images/elbe-$(date +'%Y-%m-%d.%H')-revpi-buster.img.tar.gz"
sudo mv log.txt "/mnt/wshare/elbe-images/elbe-$(date +'%Y-%m-%d.%H')-revpi-buster.log"
sudo mv armhf-revpi.xml "/mnt/wshare/elbe-images/elbe-$(date +'%Y-%m-%d.%H')-revpi-buster.xml"
