#!/bin/bash
#################### x-ui-pro v10.0.3 @ github.com/GFW4Fun ##############################################
[[ $EUID -ne 0 ]] && { echo "not root!"; exec sudo "$0" "$@"; }
##############################INFO######################################################################
msg_ok() { echo -e "\e[1;42m $1 \e[0m";}
msg_err() { echo -e "\e[1;41m $1 \e[0m";}
msg_inf() { echo -e "\e[1;34m$1\e[0m";}
echo
msg_inf		'           ___    _   _   _  ';
msg_inf		' \/ __ | |  | __ |_) |_) / \ ';
msg_inf		' /\    |_| _|_   |   | \ \_/ ';echo;
##################################Random Port and Path ###################################################
Pak=$(command -v apt||echo dnf);
RNDSTR=$(tr -dc A-Za-z0-9 </dev/urandom | head -c "$(shuf -i 6-12 -n1)");
RNDSTR2=$(tr -dc A-Za-z0-9 </dev/urandom | head -c "$(shuf -i 6-12 -n1)");
while true; do 
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
	nc -z 127.0.0.1 "$PORT" &>/dev/null || break
done
Random_country=$(echo ATBEBGBRCACHCZDEDKEEESFIFRGBHRHUIEINITJPLVNLNOPLPTRORSSESGSKUAUS | fold -w2 | shuf -n1)
TorRandomCountry=$(echo ATBEBGBRCACHCZDEDKEEESFIFRGBHRHUIEINITJPLVNLNOPLPTRORSSESGSKUAUS | fold -w2 | shuf -n1)
##################################Variables###############################################################
XUIDB="/etc/x-ui/x-ui.db";domain="";UNINSTALL="x";PNLNUM=1;CFALLOW="off";NOPATH="";RNDTMPL="n";
WarpCfonCountry="";WarpLicKey="";CleanKeyCfon="";TorCountry="";
################################Get arguments#############################################################
while [ "$#" -gt 0 ]; do
  case "$1" in
	-TorCountry) TorCountry="$2"; shift 2;;
	-WarpCfonCountry) WarpCfonCountry="$2"; shift 2;;
	-WarpLicKey) WarpLicKey="$2"; shift 2;;
	-CleanKeyCfon) CleanKeyCfon="$2"; shift 2;;
	-RandomTemplate) RNDTMPL="$2"; shift 2;;
	-Uninstall) UNINSTALL="$2"; shift 2;;
	-panel) PNLNUM="$2"; shift 2;;
	-subdomain) domain="$2"; shift 2;;
	-cdn) CFALLOW="$2"; shift 2;;
    *) shift 1;;
  esac
done
#############################################################################################################
service_enable() {
for service_name in "$@"; do
	systemctl is-active --quiet "$service_name" && systemctl stop "$service_name" > /dev/null 2>&1
	systemctl daemon-reload	> /dev/null 2>&1
	systemctl enable "$service_name" > /dev/null 2>&1
	systemctl start "$service_name" > /dev/null 2>&1
done
}
##############################TOR Change Region Country ############################################
if [[ -n "$TorCountry" ]]; then
	TorCountry=$(echo "$TorCountry" | tr '[:lower:]' '[:upper:]')
	[[ "$TorCountry" == "XX" ]] || [[ ! "$TorCountry" =~ ^[A-Z]{2}$ ]] && TorCountry=$TorRandomCountry
	TorCountry=$(echo "$TorCountry" | tr '[:upper:]' '[:lower:]')

	sudo cp -f /etc/tor/torrc /etc/tor/torrc.bak
	
	if grep -q "^ExitNodes" /etc/tor/torrc; then
		sudo sed -i "s/^ExitNodes.*/ExitNodes {$TorCountry}/" /etc/tor/torrc
	else
		echo "ExitNodes {$TorCountry}" | sudo tee -a /etc/tor/torrc
	fi

	if grep -q "^StrictNodes" /etc/tor/torrc; then
		sudo sed -i "s/^StrictNodes.*/StrictNodes 1/" /etc/tor/torrc
	else
		echo "StrictNodes 1" | sudo tee -a /etc/tor/torrc
	fi
	
	systemctl restart tor
	echo -e "\nEnter after 10 seconds:\ncurl --socks5-hostname 127.0.0.1:9050 https://ipapi.co/json/\n"
	msg_inf "Tor settings changed!"
	exit 1
fi
##############################WARP/Psiphon Change Region Country ############################################
if [[ -n "$WarpCfonCountry" || -n "$WarpLicKey" || -n "$CleanKeyCfon" ]]; then
WarpCfonCountry=$(echo "$WarpCfonCountry" | tr '[:lower:]' '[:upper:]')
cfonval=" --cfon --country $WarpCfonCountry";
[[ "$WarpCfonCountry" == "XX" ]] && cfonval=" --cfon --country ${Random_country}"
[[ "$WarpCfonCountry" =~ ^[A-Z]{2}$ ]] || cfonval="";
wrpky=" --key $WarpLicKey";[[ -n "$WarpLicKey" ]] || wrpky="";
[[ -n "$CleanKeyCfon" ]] && { cfonval=""; wrpky=""; }
######
cat > /etc/systemd/system/warp-plus.service << EOF
[Unit]
Description=warp-plus service
After=network.target nss-lookup.target

[Service]
WorkingDirectory=/etc/warp-plus/
ExecStart=/etc/warp-plus/warp-plus --scan${cfonval}${wrpky}
ExecStop=/bin/kill -TERM \$MAINPID
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
######
rm -rf ~/.cache/warp-plus
service_enable "warp-plus"; 
echo -e "\nEnter after 10 seconds:\ncurl --socks5-hostname 127.0.0.1:8086 https://ipapi.co/json/\n"
msg_inf "warp-plus settings changed!"
exit 1
fi
##############################Random Fake Site############################################################
if [[ ${RNDTMPL} == *"y"* ]]; then

cd "$HOME" || exit 1

if [[ ! -d "randomfakehtml-master" ]]; then
    wget https://github.com/GFW4Fun/randomfakehtml/archive/refs/heads/master.zip
    unzip master.zip && rm -f master.zip
fi

cd randomfakehtml-master || exit 1
rm -rf assets ".gitattributes" "README.md" "_config.yml"

RandomHTML=$(for i in *; do echo "$i"; done | shuf -n1 2>&1)
msg_inf "Random template name: ${RandomHTML}"

if [[ -d "${RandomHTML}" && -d "/var/www/html/" ]]; then
	rm -rf /var/www/html/*
	cp -a "${RandomHTML}"/. "/var/www/html/"
	msg_ok "Template extracted successfully!" && exit 1
else
	msg_err "Extraction error!" && exit 1
fi

fi
##############################Uninstall##################################################################
UNINSTALL_XUI(){
	printf 'y\n' | x-ui uninstall
	
	for i in nginx python3-certbot-nginx tor v2ray v2raya; do
		$Pak -y remove $i
	done
	
	for i in tor x-ui warp-plus; do
		 systemctl stop $i
		 systemctl disable $i
	done

	rm -rf /etc/warp-plus/ /etc/nginx/sites-enabled/
	crontab -l | grep -v "nginx\|systemctl\|x-ui\|v2ray" | crontab -
}
if [[ ${UNINSTALL} == *"y"* ]]; then
	UNINSTALL_XUI	
	clear && msg_ok "Completely Uninstalled!" && exit 1
fi
##############################Domain Validations#########################################################
while [[ -z $(echo "$domain" | tr -d '[:space:]') ]]; do
    read -rp "Enter available subdomain (sub.domain.tld): " domain
done

domain=$(echo "$domain" 2>&1 | tr -d '[:space:]' )
SubDomain=$(echo "$domain" 2>&1 | sed 's/^[^ ]* \|\..*//g')
MainDomain=$(echo "$domain" 2>&1 | sed 's/.*\.\([^.]*\..*\)$/\1/')

if [[ "${SubDomain}.${MainDomain}" != "${domain}" ]] ; then
	MainDomain=${domain}
fi
###############################Install Packages#########################################################
$Pak -y update
for pkg in epel-release cronie psmisc unzip curl nginx certbot python3-certbot-nginx sqlite sqlite3 jq openssl tor tor-geoipdb; do
  dpkg -l "$pkg" &> /dev/null || rpm -q "$pkg" &> /dev/null || $Pak -y install "$pkg"
done
service_enable "nginx" "tor" "cron" "crond"
############################### Get nginx Ver and Stop ##################################################
vercompare() { 
	if [ "$1" = "$2" ]; then echo "E"; return; fi
    [ "$(printf "%s\n%s" "$1" "$2" | sort -V | head -n1)" = "$1" ] && echo "L" || echo "G";
}
nginx_ver=$(nginx -v 2>&1 | awk -F/ '{print $2}');
ver_compare=$(vercompare "$nginx_ver" "1.25.1"); 
if [ "$ver_compare" = "L" ]; then
	 OLD_H2=" http2";NEW_H2="#";
else OLD_H2="";NEW_H2="";
fi
####### Stop nginx
sudo nginx -s stop 2>/dev/null
sudo systemctl stop nginx 2>/dev/null
sudo fuser -k 80/tcp 80/udp 443/tcp 443/udp 2>/dev/null
##################################GET SERVER IPv4-6######################################################
IP4_REGEX="^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"
IP6_REGEX="([a-f0-9:]+:+)+[a-f0-9]+"
IP4=$(ip route get 8.8.8.8 2>&1 | grep -Po -- 'src \K\S*')
IP6=$(ip route get 2620:fe::fe 2>&1 | grep -Po -- 'src \K\S*')
[[ $IP4 =~ $IP4_REGEX ]] || IP4=$(curl -s ipv4.icanhazip.com);
[[ $IP6 =~ $IP6_REGEX ]] || IP6=$(curl -s ipv6.icanhazip.com);
##############################Install SSL################################################################
certbot certonly --standalone --non-interactive --force-renewal --agree-tos --register-unsafely-without-email --cert-name "$MainDomain" -d "$domain"
if [[ ! -d "/etc/letsencrypt/live/${MainDomain}/" ]]; then
 	systemctl start nginx >/dev/null 2>&1
	msg_err "$MainDomain SSL failed! Check Domain/IP! Exceeded limit!? Try another domain or VPS!" && exit 1
fi
################################# Access to configs only with cloudflare#################################
mkdir -p /etc/nginx/sites-{available,enabled} /var/log/nginx /var/www /var/www/html
rm -rf "/etc/nginx/default.d"

nginxusr="www-data"
id -u "$nginxusr" &>/dev/null || nginxusr="nginx"

cat > "/etc/nginx/nginx.conf" << EOF
user $nginxusr;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile 65535;
events { worker_connections 65535; use epoll; multi_accept on; }
http {
	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;
	gzip on;sendfile on;tcp_nopush on;
	types_hash_max_size 4096;
	default_type application/octet-stream;
	include /etc/nginx/*.types;
	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}
EOF

rm -f "/etc/nginx/cloudflareips.sh"
cat << 'EOF' >> /etc/nginx/cloudflareips.sh
#!/bin/bash
[[ $EUID -ne 0 ]] && exec sudo "$0" "$@"
rm -f "/etc/nginx/conf.d/cloudflare_real_ips.conf" "/etc/nginx/conf.d/cloudflare_whitelist.conf"
CLOUDFLARE_REAL_IPS_PATH=/etc/nginx/conf.d/cloudflare_real_ips.conf
CLOUDFLARE_WHITELIST_PATH=/etc/nginx/conf.d/cloudflare_whitelist.conf
echo "geo \$realip_remote_addr \$cloudflare_ip {
	default 0;" >> $CLOUDFLARE_WHITELIST_PATH
for type in v4 v6; do
	echo "# IP$type"
	for ip in `curl https://www.cloudflare.com/ips-$type`; do
		echo "set_real_ip_from $ip;" >> $CLOUDFLARE_REAL_IPS_PATH;
		echo "	$ip 1;" >> $CLOUDFLARE_WHITELIST_PATH;
	done
done
echo "real_ip_header X-Forwarded-For;" >> $CLOUDFLARE_REAL_IPS_PATH
echo "}" >> $CLOUDFLARE_WHITELIST_PATH
EOF

sudo bash "/etc/nginx/cloudflareips.sh" > /dev/null 2>&1;
[[ "${CFALLOW}" == *"on"* ]] && CF_IP="" || CF_IP="#"
######################################## add_slashes /webBasePath/ #####################################
add_slashes() {
    [[ "$1" =~ ^/ ]] || set -- "/$1" ; [[ "$1" =~ /$ ]] || set -- "$1/"
    echo "$1"
}
########################################Update X-UI Port/Path for first INSTALL#########################
UPDATE_XUIDB(){
if [[ -f $XUIDB ]]; then
x-ui stop > /dev/null 2>&1
fuser "$XUIDB" 2>/dev/null
RNDSTRSLASH=$(add_slashes "$RNDSTR")
sqlite3 "$XUIDB" << EOF
	DELETE FROM 'settings' WHERE key IN ('webPort', 'webCertFile', 'webKeyFile', 'webBasePath');
	INSERT INTO 'settings' (key, value) VALUES ('webPort', '${PORT}'),('webCertFile', ''),('webKeyFile', ''),('webBasePath', '${RNDSTRSLASH}');
EOF
fi
}
###################################Install X-UI#########################################################
if ! systemctl is-active --quiet x-ui; then
	[[ "$PNLNUM" =~ ^[0-2]+$ ]] || PNLNUM=1
	PANEL=( "https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh"
		"https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh"
  		"https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install_en.sh"
	);
	printf 'n\n' | bash <(wget -qO- "${PANEL[$PNLNUM]}") ||	{ printf 'n\n' | bash <(curl -Ls "${PANEL[$PNLNUM]}"); }
	service_enable "x-ui"
 	UPDATE_XUIDB
fi
###################################Get Installed XUI Port/Path##########################################
if [[ -f $XUIDB ]]; then
	x-ui stop > /dev/null 2>&1
 	fuser "$XUIDB" 2>/dev/null
	PORT=$(sqlite3 "${XUIDB}" "SELECT value FROM settings WHERE key='webPort' LIMIT 1;" 2>&1)
 	RNDSTR=$(sqlite3 "${XUIDB}" "SELECT value FROM settings WHERE key='webBasePath' LIMIT 1;" 2>&1)	
	XUIUSER=$(sqlite3 "${XUIDB}" 'SELECT "username" FROM users;' 2>&1)
	XUIPASS=$(sqlite3 "${XUIDB}" 'SELECT "password" FROM users;' 2>&1)
	RNDSTR=$(add_slashes "$RNDSTR" | tr -d '[:space:]')
	[[ "$RNDSTR" == "/" ]] && NOPATH="#"
	if [[ -z "${PORT}" ]] || ! [[ "${PORT}" =~ ^-?[0-9]+$ ]]; then
		PORT="2053"
  	fi
else
	PORT="2053"
	RNDSTR="/";NOPATH="#";
	XUIUSER="admin";XUIPASS="admin";
fi
#################################Nginx Config###########################################################
cat > "/etc/nginx/sites-available/$MainDomain" << EOF
server {
	server_tokens off;
	server_name $MainDomain *.$MainDomain;
	listen 80;
	listen [::]:80;
	listen 443 ssl${OLD_H2};
	listen [::]:443 ssl${OLD_H2};
	${NEW_H2}http2 on; http3 on;
	index index.html index.htm index.php index.nginx-debian.html;
	root /var/www/html/;
	ssl_protocols TLSv1.2 TLSv1.3;
	ssl_ciphers HIGH:!aNULL:!eNULL:!MD5:!DES:!RC4:!ADH:!SSLv3:!EXP:!PSK:!DSS;
	ssl_certificate /etc/letsencrypt/live/$MainDomain/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/$MainDomain/privkey.pem;
	if (\$host !~* ^(.+\.)?$MainDomain\$ ){return 444;}
	if (\$scheme ~* https) {set \$safe 1;}
	if (\$ssl_server_name !~* ^(.+\.)?$MainDomain\$ ) {set \$safe "\${safe}0"; }
	if (\$safe = 10){return 444;}
	if (\$request_uri ~ "(\"|'|\`|~|,|:|--|;|%|\\$|&&|\?\?|0x00|0X00|\||\\|\{|\}|\[|\]|<|>|\.\.\.|\.\.\/|\/\/\/)"){set \$hack 1;}
	error_page 400 402 403 500 501 502 503 504 =404 /404;
	proxy_intercept_errors on;
	#X-UI Admin Panel
	location $RNDSTR {
		auth_basic "Restricted Access";
		auth_basic_user_file /etc/nginx/.htpasswd;
		proxy_redirect off;
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:$PORT;
		break;
	}
	#v2ray-ui
	location /${RNDSTR2}/ {
		auth_basic "Restricted Access";
		auth_basic_user_file /etc/nginx/.htpasswd;
		#proxy_redirect off;
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:2017/;
		break;
	}
	#Subscription Path (simple/encode)
	location ~ ^/(?<fwdport>\d+)/sub/(?<fwdpath>.*)\$ {
		if (\$hack = 1) {return 404;}
		proxy_redirect off;
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:\$fwdport/sub/\$fwdpath\$is_args\$args;
		break;
	}
	#Subscription Path (json/fragment)
	location ~ ^/(?<fwdport>\d+)/json/(?<fwdpath>.*)\$ {
		if (\$hack = 1) {return 404;}
		proxy_redirect off;
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:\$fwdport/json/\$fwdpath\$is_args\$args;
		break;
	}
	#Xray Config Path
	location ~ ^/(?<fwdport>\d+)/(?<fwdpath>.*)\$ {
		${CF_IP}if (\$cloudflare_ip != 1) {return 404;}
		if (\$hack = 1) {return 404;}
		client_max_body_size 0;
		client_body_timeout 1d;
		grpc_read_timeout 1d;
		grpc_socket_keepalive on;
		proxy_read_timeout 1d;
		proxy_http_version 1.1;
		proxy_buffering off;
		proxy_request_buffering off;
		proxy_socket_keepalive on;
		proxy_set_header Upgrade \$http_upgrade;
		proxy_set_header Connection "upgrade";
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		#proxy_set_header CF-IPCountry \$http_cf_ipcountry;
		#proxy_set_header CF-IP \$realip_remote_addr;
		if (\$content_type ~* "GRPC") {
			grpc_pass grpc://127.0.0.1:\$fwdport\$is_args\$args;
			break;
		}
		if (\$http_upgrade ~* "(WEBSOCKET|WS)") {
			proxy_pass http://127.0.0.1:\$fwdport\$is_args\$args;
			break;
		}
		if (\$request_method ~* ^(PUT|POST|GET)\$) {
			proxy_pass http://127.0.0.1:\$fwdport\$is_args\$args;
			break;
		}
	}
	$NOPATH location / { try_files \$uri \$uri/ =404; }
}
EOF
if [[ -f "/etc/nginx/sites-available/$MainDomain" ]]; then
	unlink "/etc/nginx/sites-enabled/default" >/dev/null 2>&1
	rm -f "/etc/nginx/sites-enabled/default" "/etc/nginx/sites-available/default"
	ln -fs "/etc/nginx/sites-available/$MainDomain" "/etc/nginx/sites-enabled/" 2>/dev/null
fi
##################################Check Nginx status####################################################
if ! systemctl start nginx > /dev/null 2>&1 || ! nginx -t &>/dev/null || nginx -s reload 2>&1 | grep -q error; then
	pkill -9 nginx || killall -9 nginx
	nginx -c /etc/nginx/nginx.conf
	nginx -s reload
fi
x-ui start > /dev/null 2>&1
############################################Warp Plus (MOD)#############################################
systemctl stop warp-plus > /dev/null 2>&1
rm -rf ~/.cache/warp-plus /etc/warp-plus/
mkdir -p /etc/warp-plus/
chmod 777 /etc/warp-plus/
## Download Cloudflare Warp Mod (wireguard)
warpPlusDL="https://github.com/bepass-org/warp-plus/releases/latest/download/warp-plus_linux"

case "$(uname -m | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')" in
	x86_64 | amd64) wppDL="${warpPlusDL}-amd64.zip" ;;
	aarch64 | arm64) wppDL="${warpPlusDL}-arm64.zip" ;;
	armv*) wppDL="${warpPlusDL}-arm7.zip" ;;
	mips) wppDL="${warpPlusDL}-mips.zip" ;;
	mips64) wppDL="${warpPlusDL}-mips64.zip" ;;
	mips64le) wppDL="${warpPlusDL}-mips64le.zip" ;;
	mipsle*) wppDL="${warpPlusDL}-mipsle.zip" ;;
	riscv*) wppDL="${warpPlusDL}-riscv64.zip" ;;
	*) wppDL="${warpPlusDL}-amd64.zip" ;;
esac  

wget --quiet -P /etc/warp-plus/ "${wppDL}" || curl --output-dir /etc/warp-plus/ -LOs "${wppDL}" 
find "/etc/warp-plus/" -name '*.zip' | xargs -I {} sh -c 'unzip -d "$0" "{}" && rm -f "{}"' "/etc/warp-plus/"
cat > /etc/systemd/system/warp-plus.service << EOF
[Unit]
Description=warp-plus service
After=network.target nss-lookup.target

[Service]
WorkingDirectory=/etc/warp-plus/
ExecStart=/etc/warp-plus/warp-plus --scan --cfon --country $Random_country
ExecStop=/bin/kill -TERM \$MAINPID
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
service_enable "warp-plus"
##########################################Install v2ray-core + v2rayA-webui#############################
if [[ "$Pak" = "dnf" ]]; then
	sudo dnf copr enable zhullyb/v2rayA
else
	wget -qO - https://apt.v2raya.org/key/public-key.asc | sudo tee /etc/apt/keyrings/v2raya.asc
	echo "deb [signed-by=/etc/apt/keyrings/v2raya.asc] https://apt.v2raya.org/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
fi
$Pak -y update
$Pak -y install v2ray
$Pak -y install v2raya
service_enable "v2ray" "v2raya"
######################cronjob for ssl/reload service/cloudflareips######################################
crontab -l | grep -v "nginx\|systemctl\|x-ui\|v2ray" | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * * sudo su -c 'x-ui restart > /dev/null 2>&1 && systemctl reload v2ray v2raya warp-plus tor';") | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * * sudo su -c 'nginx -s reload 2>&1 | grep -q error && { pkill nginx || killall nginx; nginx -c /etc/nginx/nginx.conf; nginx -s reload; }';") | crontab -
(crontab -l 2>/dev/null; echo "0 0 1 * * sudo su -c 'certbot renew --nginx --force-renewal --non-interactive --post-hook \"nginx -s reload\" > /dev/null 2>&1';") | crontab -
(crontab -l 2>/dev/null; echo "* * * * * sudo su -c '[[ \"\$(curl -s --socks5-hostname 127.0.0.1:9050 checkip.amazonaws.com)\" =~ ^((([0-9]{1,3}\.){3}[0-9]{1,3})|(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}))\$ ]] || systemctl restart tor';") | crontab -
(crontab -l 2>/dev/null; echo "* * * * * sudo su -c '[[ \"\$(curl -s --socks5-hostname 127.0.0.1:8086 checkip.amazonaws.com)\" =~ ^((([0-9]{1,3}\.){3}[0-9]{1,3})|(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}))\$ ]] || systemctl restart warp-plus';") | crontab -
#(crontab -l 2>/dev/null; echo "* * * * * sudo su -c '[[ \"\$(curl -s --socks5-hostname 127.0.0.1:20170 checkip.amazonaws.com)\" =~ ^((([0-9]{1,3}\.){3}[0-9]{1,3})|(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}))\$ ]] || systemctl restart warp-plus';") | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * 0 sudo bash /etc/nginx/cloudflareips.sh > /dev/null 2>&1;") | crontab -
##################################Show Details##########################################################
if systemctl is-active --quiet x-ui || [ -e /etc/systemd/system/x-ui.service ]; then clear
	printf '0\n' | x-ui | grep --color=never -i ':'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	nginx -T | grep -i 'ssl_certificate\|ssl_certificate_key'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	certbot certificates | grep -i 'Path:\|Domains:\|Expiry Date:'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	IPInfo=$(curl -Ls "https://ipapi.co/json" || curl -Ls "https://ipinfo.io/json")
	echo "Hostname: $(uname -n) | $(echo "$IPInfo" | jq -r '.org, .country' | paste -sd' | ')"
	[[ -n $IP4 ]] && [[ "$IP4" =~ $IP4_REGEX ]] && msg_inf "IPv4: http://$IP4:$PORT$RNDSTR"
	[[ -n $IP6 ]] && [[ "$IP6" =~ $IP6_REGEX ]] && msg_inf "IPv6: http://[$IP6]:$PORT$RNDSTR"
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	sudo sh -c "echo -n '${XUIUSER}:' >> /etc/nginx/.htpasswd && openssl passwd -apr1 '${XUIPASS}' >> /etc/nginx/.htpasswd"
	msg_inf "X-UI <Double Login Panel> https://${domain}${RNDSTR}"
	msg_inf "v2rayA <Double Login Panel> https://${domain}/${RNDSTR2}/\n"
	echo "Username: $XUIUSER"
	echo "Password: $XUIPASS"
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	msg_inf "Please Save this Screen!!"	
else
	nginx -t && printf '0\n' | x-ui | grep --color=never -i ':'
	msg_err "X-UI-PRO : Installation error..."
fi
################################################ N-joy #################################################
