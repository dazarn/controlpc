#!/bin/bash
sudo apt update
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo rkhunter --propupd
