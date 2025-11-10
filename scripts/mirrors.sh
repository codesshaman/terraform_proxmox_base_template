#!/bin/bash

cp .opentofu.rc ~

echo " " >> .bashrc
echo "export TF_CLI_CONFIG_FILE=/home/$USER/.opentofu.rc" >> ~/.bashrc

source ~/.bashrc
