#!/bin/bash

# Wait for the attached volume to be available
while [ ! -e /dev/xvdh ]; do
  sleep 1
done

# Create filesystem on the new volume (if not already created)
if ! blkid /dev/xvdh; then
  mkfs -t ext4 /dev/xvdh
fi

# Create mount point and mount the volume
mkdir -p /mnt/resized_volume
mount /dev/xvdh /mnt/resized_volume

# Add to fstab for persistence
echo "/dev/xvdh /mnt/resized_volume ext4 defaults,nofail 0 2" >> /etc/fstab

# For root volume resizing (more complex operation)
# This would require stopping the instance, modifying the root volume size,
# then running growpart and resize2fs/xfs_growfs