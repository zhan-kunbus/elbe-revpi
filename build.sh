#!/bin/bash


BDIR="/var/cache/elbe/d6837082-6eae-4cc3-a6bf-a1bffd9f4928"

elbe preprocess armhf-revpi.xml

elbe control set_xml "$BDIR" ./preprocess.xml
elbe control build "$BDIR"
elbe control wait_busy "$BDIR"

elbe control get_file "$BDIR" armhf-revpi.img.tar.gz
elbe control get_file "$BDIR" log.txt

