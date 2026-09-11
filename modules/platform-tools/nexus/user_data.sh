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
dnf install -y docker
systemctl enable --now docker

mkdir -p ${data_mount_path}
chown -R 200:200 ${data_mount_path} || true

docker stop nexus || true
docker rm nexus || true
docker run -d --name nexus \
  --restart always \
  -p ${web_port}:8081 \
  -p ${docker_registry_port}:8082 \
  -v ${data_mount_path}:/nexus-data \
  sonatype/nexus3:${nexus_version}
