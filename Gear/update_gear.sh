#!/bin/bash

sudo systemctl stop gear
$HOME/gear-node purge-chain -y
wget https://builds.gear.rs/gear-nightly-linux-x86_64.tar.xz
sudo tar -xvf gear-nightly-linux-x86_64.tar.xz -C /root
rm gear-nightly-linux-x86_64.tar.xz
sudo systemctl start gear
echo "Обновление завершено успешно"
