# Make it the same as the image from imagebakery: the non-root user has
# also PATH refering the  *sbin pathes
# https://github.com/RPi-Distro/pi-gen/blob/dcfd74d7d1fa293065ac6d565711e9ff891fe2b8/stage2/01-sys-tweaks/00-patches/05-path.diff#L10
P="\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\
\/bin:\/usr\/local\/games:\/usr\/games";
sed -r -i "s/(ENV_PATH.*PATH=).*/\1"$P"/g" /etc/login.defs;
P=\""$P"\";
sed -r -i "7c\ \ PATH="$P"" /etc/profile;
