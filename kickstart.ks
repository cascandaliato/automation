eula --agree

text
cdrom
skipx

keyboard --vckeymap=us --xlayouts='us'
lang en-US.UTF-8
timezone Europe/Rome --isUtc --ntpservers=0.it.pool.ntp.org,1.it.pool.ntp.org,2.it.pool.ntp.org,3.it.pool.ntp.org

network --bootproto=dhcp --ipv6=auto --hostname=pannacotta.local # --activate # --onboot=yes
firewall --enable --ssh
selinux --enforcing

auth --enableshadow --passalgo=sha512
rootpw --iscrypted $6$Qls43AfQOShsQMjd$Nvl4qvN7dQx0pJ2I85HqXgH8EssAM.n12U/vVMHpTeNDeQaXp1rRCMXlz5MaLMuidl7KH8F44uTibgOghJ2zc0
user --name=foobar --password=$6$LyYO7Q85Drdu5HRQ$jVjqVTfdMq/BST2tKFsyI/oo/Fgsa/kEZmvCd63qB0a0WDWlhMa6F/O1Rikcn1aEjEuHvOGHiP.FVgjHkfhX5/ --iscrypted --gecos="Foo Bar" --groups=wheel

ignoredisk --only-use=sda
zerombr
#bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
bootloader --location=mbr --boot-drive=sda
clearpart --all --drives=sda --initlabel
autopart --type=lvm

services --enabled="chronyd"

reboot --eject

%packages
@^minimal
%end

%addon com_redhat_kdump --enable --reserve-mb='auto'
%end

%post --interpreter=/usr/bin/bash --erroronfail --log=/var/log/kickstart-post.log
systemctl enable tmp.mount
%end
