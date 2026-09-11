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

sysctl -w vm.max_map_count=${sysctl_max_map_count}
sysctl -w fs.file-max=${sysctl_fs_file_max}
echo "vm.max_map_count=${sysctl_max_map_count}" >> /etc/sysctl.conf
echo "fs.file-max=${sysctl_fs_file_max}" >> /etc/sysctl.conf

dnf update -y
dnf install -y docker
systemctl enable --now docker

mkdir -p ${data_mount_path}/postgres ${data_mount_path}/sonarqube_data ${data_mount_path}/sonarqube_extensions ${data_mount_path}/sonarqube_logs
chown -R 70:70 ${data_mount_path}/postgres || true
chown -R 1000:1000 ${data_mount_path} || true

docker network create sonar-net || true

docker stop sonar-db || true
docker rm sonar-db || true
docker run -d --name sonar-db \
  --network sonar-net \
  --restart always \
  -e POSTGRES_USER=${db_username} \
  -e POSTGRES_PASSWORD=${db_password} \
  -e POSTGRES_DB=${db_name} \
  -v ${data_mount_path}/postgres:/var/lib/postgresql/data \
  postgres:${postgres_version}

sleep ${db_init_sleep}

docker stop sonarqube || true
docker rm sonarqube || true
docker run -d --name sonarqube \
  --network sonar-net \
  --restart always \
  -p ${web_port}:9000 \
  -e SONAR_JDBC_URL=jdbc:postgresql://sonar-db:5432/${db_name} \
  -e SONAR_JDBC_USERNAME=${db_username} \
  -e SONAR_JDBC_PASSWORD=${db_password} \
  -v ${data_mount_path}/sonarqube_data:/opt/sonarqube/data \
  -v ${data_mount_path}/sonarqube_extensions:/opt/sonarqube/extensions \
  -v ${data_mount_path}/sonarqube_logs:/opt/sonarqube/logs \
  sonarqube:${sonarqube_version}
