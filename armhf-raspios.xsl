<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE e [
	<!ENTITY stage0pre SYSTEM "stage0/preseed.xml">
	<!ENTITY stage0pkg SYSTEM "stage0/pkg-list.xml">
	<!ENTITY stage0fin SYSTEM "stage0/finetuning.sh">
	<!ENTITY stage0pbd SYSTEM "stage0/pbuilder.xml">

	<!ENTITY stage1pre SYSTEM "stage1/preseed.xml">
	<!ENTITY stage1pkg SYSTEM "stage1/pkg-list.xml">
	<!ENTITY stage1fin SYSTEM "stage1/finetuning.sh">
	<!ENTITY stage1pbd SYSTEM "stage1/pbuilder.xml">
]>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

<ns0:RootFileSystem xmlns:ns0="https://www.linutronix.de/projects/Elbe" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" created="2009-05-20T08:50:56" revision="6" xsi:schemaLocation="https://www.linutronix.de/projects/Elbe dbsfed.xsd">
	<project>
		<!-- human readable description of the project -->
		<name><xsl:value-of select="parameters/project-name"/></name>
		<version><xsl:value-of select="parameters/project-version"/></version>
		<description><xsl:value-of select="parameters/project-description"/></description>

		<!-- buildtype is used to configure qemu-user and debian arch -->
		<buildtype>armhf</buildtype>
		<mirror>
			<!-- primary mirror is used by debootstrap -->
			<primary_host>raspbian.raspberrypi.org</primary_host>
			<primary_path>raspbian</primary_path>
			<primary_proto>http</primary_proto>
			<url-list>
				<url>
					<binary>http://raspbian.raspberrypi.org/raspbian buster contrib non-free rpi</binary>
					<source>http://raspbian.raspberrypi.org/raspbian buster main contrib non-free rpi</source>
					<key>http://raspbian.raspberrypi.org/raspbian.public.key</key>
				</url>
				<url>
					<binary>http://archive.raspberrypi.org/debian buster main ui</binary>
					<source>http://archive.raspberrypi.org/debian buster main ui</source>
					<key>http://archive.raspberrypi.org/debian/raspberrypi.gpg.key</key>
				</url>
			</url-list>
		</mirror>
		<preseed>
			<xsl:if test="parameters/build-stage &gt;= 0">&stage0pre; </xsl:if>
			<xsl:if test="parameters/build-stage &gt;= 1">&stage1pre; </xsl:if>
		</preseed>

		<suite>buster</suite>
	</project>
	<target>
		<!-- content for /etc/hostname -->
		<hostname>raspios</hostname>
		<!-- content for /etc/domainname -->
		<domain>raspberrypi.org</domain>
		<!-- root password -->
		<passwd>root</passwd>
		<!-- run a getty here: -->
		<console>ttyS0,115200</console>
		<!-- speed up build with debootstrap variant minbase.
		Using minbase here and explicit install of systemd later
		on speed up the installation process, since it reduces
		the emulated part (run in QEMU) of the installation
		significant.
		-->
		<package>
			<!-- build a tarball of the target image -->
			<tar>
				<name>armhf-raspios.tgz</name>
			</tar>
		</package>
		<!-- define an sdcard image -->
		<images>
			<msdoshd>
				<!-- name of the image file -->
				<name>armhf-raspios.img</name>
				<size>3700MiB</size>
					<!-- partition layout -->
					<partition>
						<size>50MiB</size>
						<!-- label needs to match with the fstab entry below -->
						<label>boot</label>
						<bootable/>
					</partition>
					<partition>
						<size>remain</size>
						<label>rfs</label>
					</partition>
			</msdoshd>
		</images>
		<fstab>
			<bylabel>
				<!-- label needs to match with an image entry aboth -->
				<label>rfs</label>
				<mountpoint>/</mountpoint>
				<fs>
					<!-- fs type and options -->
					<type>ext2</type>
					<tune2fs>-i 0</tune2fs>
				</fs>
			</bylabel>
			<bylabel>
				<label>boot</label>
				<mountpoint>/boot</mountpoint>
				<fs>
					<type>vfat</type>
				</fs>
			</bylabel>
		</fstab>

		<pkg-list>
			<xsl:if test="parameters/build-stage &gt;= 0"> &stage0pkg; </xsl:if>
			<xsl:if test="parameters/build-stage &gt;= 1"> &stage1pkg; </xsl:if>
		</pkg-list>
		<finetuning>
			<command>
				<xsl:if test="parameters/build-stage &gt;= 0"> &stage0fin; </xsl:if>
				<xsl:if test="parameters/build-stage &gt;= 1"> &stage1fin; </xsl:if>
			</command>
		</finetuning>
		<pbuilder>
			<xsl:if test="parameters/build-stage &gt;= 0"> &stage0pbd; </xsl:if>
			<xsl:if test="parameters/build-stage &gt;= 1"> &stage0pbd; </xsl:if>
		</pbuilder>
	</target>
	<archivedir>
		<xsl:if test="parameters/build-stage &gt;= 0">stage0/archive/</xsl:if>
		<xsl:if test="parameters/build-stage &gt;= 1">stage1/archive/</xsl:if>
	</archivedir>
</ns0:RootFileSystem>

</xsl:template>
</xsl:stylesheet>