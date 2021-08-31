sudo apt update
sudo apt install nfs-kernel-server -y
# create dir and mount
sudo mkdir /mnt/efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-e2ad8656.efs.us-east-1.amazonaws.com:/ /mnt/efs
# check disk
sudo fdisk -l /dev/nvme1n1 fs-e2ad8656.efs.us-east-1.amazonaws.com:/
# copy disk
sudo dd if=/dev/nvme1n1 of=fs-e2ad8656.efs.us-east-1.amazonaws.com:
# unmount
sudo umount fs-e2ad8656.efs.us-east-1.amazonaws.com: