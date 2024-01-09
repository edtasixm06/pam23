#! /bin/bash

for user in unix01 unix02 unix03 unix04 unix05
do
  useradd -m -s /bin/bash $user
  echo -e "$user\n$user" | passwd $user
done


cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/ldap.conf /etc/ldap/ldap.conf
#cp /opt/docker/common-account /etc/pam.d/common-account
#cp /opt/docker/common-auth /etc/pam.d/common-auth
#cp /opt/docker/common-password /etc/pam.d/common-password
cp /opt/docker/common-session /etc/pam.d/common-session
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml

/usr/sbin/nscd
/usr/sbin/nslcd
sleep infinity
/bin/bash



