#!/bin/bash
### https://github.com/GFW4Fun
Green="\033[32m"
Red="\033[31m"
Yellow="\033[33m"
Blue="\033[36m"
Font="\033[0m"
OK="${Green}[OK]${Font}"
ERROR="${Red}[ERROR]${Font}"
function msg_inf() {  echo -e "${Blue} $1 ${Font}"; }
function msg_ok() { echo -e "${OK} ${Blue} $1 ${Font}"; }
function msg_err() { echo -e "${ERROR} ${Yellow} $1 ${Font}"; }
###################################
apt install unzip -y
cd $HOME
if [[ -d "randomfakehtml-master" ]]; then
	cd randomfakehtml-master
else
	wget https://github.com/GFW4Fun/randomfakehtml/archive/refs/heads/master.zip
	unzip master.zip && rm master.zip
	cd randomfakehtml-master
	rm -rf assets
	rm ".gitattributes" "README.md" "_config.yml"
fi
###################################
#RandomHTML=$(for i in *; do echo "$i"; done | shuf -n1 2>&1)
RandomHTML=$(a=(*); echo ${a[$((RANDOM % ${#a[@]}))]} 2>&1)
msg_inf "Random template name: ${RandomHTML}"
#################################
if [[ -d "${RandomHTML}" && -d "/var/www/html/" ]]; then
	rm -rf /var/www/html/*
	cp -a ${RandomHTML}/. "/var/www/html/"
	msg_ok "Template extracted successfully!"
else
	msg_err "Extraction error!"
fi
#################################
