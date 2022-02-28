#!/bin/bash

# assign variables
ACTION=${1}
version="1.0.0"

function start() {

echo sudo yum update -y
echo sudo amazon-linux-extras install nginx1.12 -y
echo sudo chkconfig nginx on 
echo sudo aws s3 cp s3://jakemalwitz-assignment-webserver/index.html 
/usr/share/nginx/html/index.html
echo sudo service nginx start
}

function remove() {
echo sudo service nginx stop
rm /usr/share/nginx/html/*
echo sudo yum remove nginx -y
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
	*)
	start
	exit 1
esac
