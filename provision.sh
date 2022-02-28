#!/bin/bash

# assign variables
ACTION=${1}
version="1.0.0"

function start() {

sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
ps ax | grep nginx | grep -v grep
sudo service nginx start
sudo chkconfig nginx on 
sudo aws s3 cp s3://jakemalwitz-assignment-webserver/index.html 
/usr/share/nginx/html/index.html
}

function remove() {
sudo service nginx stop
sudo rm /usr/share/nginx/html/*
sudo yum remove nginx -y
}

function show_version() {

echo $version
}

function display_help() {

cat << EOF
Usage: ${0} {-h|--help|-r|--remove|-v|--version}
OPTIONS:
	-No arguments | Update packages, install nginx, dl files, start service   
	-r | --remove   Stop service, remove files
	-h | --help	Display the command help
	-v | --version  Display the current version
Examples:
	Start/Download:
		$ ${0} 
	Stop/Remove:
		$ ${0} -r
	Display help:
		$ ${0} -h
	Display version:
		$ ${0} -v
EOF
}

case "$ACTION" in
	-h|--help)
		display_help
		;;
	-r|--remove)
		remove
		;;
	-v|--version)
		show_version
		;;
   	 "")
	start
	;;
	*)
	echo "Usage ${0} {-r|-h|-v}"
	exit 1
esac
