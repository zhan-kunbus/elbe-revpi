#!/bin/bash

LIST=($(apt list --installed | cut -d/ -f1))

for pkg in "${LIST[@]}"
do
	DC=$(apt rdepends --installed "$pkg" 2>/dev/null | grep "  Depends:" | wc -l)
	if [ "0" != $DC ]; then
		continue
	fi
	DC=$(apt rdepends --installed "$pkg" 2>/dev/null | grep "  PreDepends:" | wc -l)
	if [ "0" != $DC ]; then
		continue
	fi
	DC=$(apt rdepends --installed "$pkg" 2>/dev/null | grep " |Depends:" | wc -l)
	if [ "0" != $DC ]; then
		continue
	fi
	echo "<pkg>$pkg</pkg>"
done
