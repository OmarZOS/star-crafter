#!/bin/bash

#update your ubuntu Update the system package cache

sudo apt update

#install openssh-server

sudo apt install \openssh-server \software-properties-common \python-software-properties

#test ssh installation

echo "Please run: logout in order to continue the installation"
ssh localhost

#install java

sudo add-apt-repository ppa:webupd8team/java  #sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-8-jdk

#To verify the java version you can use the following command:

java -version

#-------------------------------------------------------------------
#connect your PC to the network.
#add the static IPv4 address 
#make IPv6 link-local only.
#ping the master at 192.168.0.1

#copy the content of hosts in your /etc/hosts
#and add your machine to the /etc/hosts
#update hosts

sudo cp hosts /etc/hosts


#-------------------------------------------------------------------
#Creation of a dedicated user and group for Hadoop
sudo addgroup hadoopgroup
sudo adduser --ingroup hadoopgroup hadoopuser
sudo adduser hadoopuser sudo

#execute the internal.sh script to install hadoop

sudo -H -u hadoopuser bash -c '$PWD/internal.sh' 


