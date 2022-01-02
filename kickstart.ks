
#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
cdrom
# Use text install
text
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us','it'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=enp0s3 --ipv6=auto --activate
network  --hostname=pannacotta

# Root password
rootpw --iscrypted $6$Qls43AfQOShsQMjd$Nvl4qvN7dQx0pJ2I85HqXgH8EssAM.n12U/vVMHpTeNDeQaXp1rRCMXlz5MaLMuidl7KH8F44uTibgOghJ2zc0
# System services
services --enabled="chronyd"
# System timezone
timezone Europe/Rome --isUtc --ntpservers=0.centos.pool.ntp.org,1.centos.pool.ntp.org,2.centos.pool.ntp.org,3.centos.pool.ntp.org
user --name=dietpi --password=$6$LyYO7Q85Drdu5HRQ$jVjqVTfdMq/BST2tKFsyI/oo/Fgsa/kEZmvCd63qB0a0WDWlhMa6F/O1Rikcn1aEjEuHvOGHiP.FVgjHkfhX5/ --iscrypted --gecos="Foo Bar"
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
autopart --type=lvm
# Partition clearing information
clearpart --none --initlabel

%packages
@^minimal
@core
chrony
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
