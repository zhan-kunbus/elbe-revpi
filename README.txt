armhf-raspios.xml:
	The main XML file for ELBE.

stageX/pkg-list.xml:
	Give the packages to install in this stage.
stageX/preseed.xml:
	Specify the debconf selections for the packages in this stage.
stageX/finetuning.sh:
	The shell commands to do the finetuning for the packages.
stageX/parameters.xml:
	The parameters might be used in this stage (e.g. finetuning, but maybe not needed)
stageX/pbuilder.xml:
	The packages needed to be built by pbuilder in this stage.
stageX/archive/:
	The files for <archivedir> of this stage.

To generate the XML file for ELBE:
elbe preprocess armhf-raspios.xml -o output.xml

To submit the XML file to ELBE;
elbe initvm submit --skip-download --skip-build-bin --skip-build-sources --keep-files ./output.xml
