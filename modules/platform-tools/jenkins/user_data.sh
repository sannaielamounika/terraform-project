#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

DEVICE=""
if [ -b /dev/nvme1n1 ]; then
  DEVICE="/dev/nvme1n1"
elif [ -b /dev/xvdf ]; then
  DEVICE="/dev/xvdf"
fi

if [ -n "$DEVICE" ]; then
  if ! blkid "$DEVICE"; then
    mkfs.ext4 "$DEVICE"
  fi
  mkdir -p ${data_mount_path}
  mount "$DEVICE" ${data_mount_path} || true
  echo "$DEVICE ${data_mount_path} ext4 defaults,nofail 0 2" >> /etc/fstab
fi

dnf update -y
dnf install -y java-21-amazon-corretto-devel wget fontconfig git

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

if [ -n "${jenkins_version}" ]; then
  dnf install -y jenkins-${jenkins_version} || dnf install -y jenkins
else
  dnf install -y jenkins
fi

if [ "${data_mount_path}" != "/var/lib/jenkins" ] && [ "${data_mount_path}" != "/var/jenkins_home" ]; then
  mkdir -p /etc/systemd/system/jenkins.service.d
  cat <<EOF > /etc/systemd/system/jenkins.service.d/override.conf
[Service]
Environment="JENKINS_HOME=${data_mount_path}"
EOF
  systemctl daemon-reload
fi

chown -R jenkins:jenkins ${data_mount_path} /var/lib/jenkins /var/log/jenkins /var/cache/jenkins || true
systemctl enable --now jenkins
