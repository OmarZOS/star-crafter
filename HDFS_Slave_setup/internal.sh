#!/bin/bash

#configure password-less SSH for hadoopuser 

ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa 
cat ~/.ssh/id_rsa.pub>> ~/.ssh/authorized_keys 
chmod 0600 ~/.ssh/authorized_keys

#Make sure hadoopuser can ssh to its own account without password

echo "Please run: logout in order to continue the installation"
ssh localhost

#Note: If you get error: ssh: connect to host localhost port 22: Connection refused, then, please try to install ssh-server using below command.

#sudo apt-get install ssh

#give hadoopuser ownership on opt files

sudo chown hadoopuser:hadoopgroup  -R /opt/

#then copy the folders inside the opt folder into your opt.
sudo cp -R opt/* /opt/

#etc/profile and link to .bashrc

#copy the contenent of profile into your /etc/profile
sudo cp profile /etc/profile

#The following command will create a symbolic link between ~/.bashrc and /etc/profile and apply the changes made to /etc/profile

sudo ln -sf /etc/profile /root/.bashrc
source /etc/profile


sudo chown hadoopuser:hadoopgroup  -R /opt/
#----------------------------------------------------------------------------------------
#for Spark, you MUST install python in the following location /home/hadoopuser/miniconda3

sudo wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo chmod +x Miniconda3-latest-Linux-x86_64.sh
sudo ./Miniconda3-latest-Linux-x86_64.sh

#Must be done on the Master
#Finally, add your data node (Slave) to workers file located in /opt/hadoop/etc/hadoop

#After configuring data nodes you have to make sure that the name node has a password less access to them:

#ssh-copy-id -i /home/hadoopuser/.ssh/id_rsa.pub hadoopuser@hadoop-slave-04

