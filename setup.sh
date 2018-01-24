#!/bin/bash
# run with
# 'sudo su'
# 'source setup.sh'
# to force variables to be exported in the same shell
source ./root_setup.sh
su ubuntu << 'eof'
source ./user_setup.sh

echo "scheduling startup at reboot"
chmod +x ./startup.sh
crontab -r
echo "SHELL=/bin/bash" >> /tmp/usercron
echo "DISPLAY=$DISPLAY" >> /tmp/usercron
echo "PATH=$PATH" >> /tmp/usercron
echo "@reboot /home/ubuntu/nvidia-hw-accelerated-box/startup.sh" >> /tmp/usercron
crontab /tmp/usercron
rm -f /tmp/usercron
eof

echo "cleaning setup files"
rm ./*setup.sh
rm ./*.md

echo "creating nvidia driver volume for docker (the only way I know how)"
nvidia-docker run --rm nvidia/cuda nvidia-smi

echo "building selenium hub and node images"
cd grid
bash build.sh
cd ..

echo "setup complete... rebooting now"
reboot now
