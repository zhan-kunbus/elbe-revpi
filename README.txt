armhf-raspios.xsl:
	Define how the XML will be generaged.
build-image.xml:
	Define the general parameters, e.g. name or version of the project, name of the image, etc.

stageX/pkg-list:
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
xsltproc -o output.xml armhf-raspios.xsl build-image.xml

To print the XML file with well formatted:
xsltproc armhf-raspios.xsl build-image.xml | xmllint --format -