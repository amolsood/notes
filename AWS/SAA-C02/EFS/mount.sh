#!/bin/bash
sudo yum update -y
sudo yum -y install nfs-utils
sudo service nfs start
cd ~
mkdir efs-mount
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-b6133102.efs.us-east-1.amazonaws.com:/ ~/efs-mount


## Auto Mount commands
## sudo vim /etc/fstab
## fs-b6133102.efs.us-east-1.amazonaws.com:/ ~/efs-mount nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0

## Check file system
## df -h


## Auto-generated from EC2 launch wizard
###cloud-config
##package_update: true
##package_upgrade: true
##runcmd:
##- yum install -y amazon-efs-utils
##- apt-get -y install amazon-efs-utils
##- yum install -y nfs-utils
##- apt-get -y install nfs-common
##- file_system_id_1=fs-b6133102
##- efs_mount_point_1=/mnt/efs/fs1
##- mkdir -p "${efs_mount_point_1}"
##- test -f "/sbin/mount.efs" && printf "\n${file_system_id_1}:/ ${efs_mount_point_1} efs tls,_netdev\n" >> /etc/fstab || printf "\n${file_system_id_1}.efs.us-east-1.amazonaws.com:/ ${efs_mount_point_1} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0\n" >> /etc/fstab
##- test -f "/sbin/mount.efs" && grep -ozP 'client-info]\nsource' '/etc/amazon/efs/efs-utils.conf'; if [[ $? == 1 ]]; then printf "\n[client-info]\nsource=liw\n" >> /etc/amazon/efs/efs-utils.conf; fi;
##- retryCnt=15; waitTime=30; while true; do mount -a -t efs,nfs4 defaults; if [ $? = 0 ] || [ $retryCnt -lt 1 ]; then echo File system mounted successfully; break; fi; echo File system not available, retrying to mount.; ((retryCnt--)); sleep $waitTime; done;