#!/bin/bash

BDIR=$(elbe control create_project)

elbe control set_xml "$BDIR" ./pre-build.xml

elbe control build "$BDIR"

elbe control wait_busy "$BDIR"

elbe control set_xml "$BDIR" ./armhf-revpi.xml

elbe control build "$BDIR"

elbe control wait_busy "$BDIR"

elbe control get_file "$BDIR" armhf-revpi.img.tar.gz
