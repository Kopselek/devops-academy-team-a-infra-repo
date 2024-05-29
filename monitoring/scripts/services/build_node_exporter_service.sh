#! /bin/bash

adduser exporteruser --gecos "" --disabled-password

wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

tar xvfz ./node_exporter-1.6.1.linux-amd64.tar.gz

mv ./node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/node_exporter

rm -r ./node_exporter-1.6.1.linux-amd64
rm ./node_exporter-1.6.1.linux-amd64.tar.gz

cp ./node-exporter.service /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
