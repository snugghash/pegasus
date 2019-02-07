#!/bin/bash

# Copyright 2015 Insight Data Science
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
sudo dpkg --configure -a

sudo add-apt-repository ppa:openjdk-r/ppa -y
wait
sudo apt-get update
wait
sudo apt-get --yes install ssh rsync scala python-dev python-pip python-numpy python-scipy python-pandas gfortran git supervisor ruby bc python3 python3-pip python3-setuptools
#sudo dpkg --configure -a
wait
#pip install --upgrade pip


sudo apt-get remove --purge openjdk* java-common default-jdk
sudo apt-get autoremove --purge
sudo apt-get install openjdk-8-jdk
#sudo dpkg --configure -a

# get sbt repository
wget https://dl.bintray.com/sbt/debian/sbt-0.13.7.deb -P ~/Downloads
sudo dpkg -i ~/Downloads/sbt-*
#sudo dpkg --configure -a
wait

# get maven3 repository
#sudo apt-get purge maven maven2 maven3
#sudo apt-add-repository -y ppa:andrei-pozolotin/maven3
#sudo apt-get update
#sudo apt-get --yes install maven3
#sudo dpkg --configure -a

sudo update-java-alternatives -s java-1.8.0-openjdk-amd64



sudo pip install nose seaborn boto scikit-learn
#sudo pip install "ipython[notebook]==5.5.0"

if ! grep "export JAVA_HOME" ~/.profile; then
  echo -e "\nexport JAVA_HOME=/usr" | cat >> ~/.profile
  echo -e "export PATH=\$PATH:\$JAVA_HOME/bin" | cat >> ~/.profile
fi
wait

sudo rm /var/lib/dpkg/lock
#sudo dpkg --configure -a
wait
sudo apt-get --yes install bc
wait
#sudo dpkg --configure -a
