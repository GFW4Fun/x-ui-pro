#!/bin/bash
#################### x-ui-pro v8.0.0 @ github.com/GFW4Fun ##############################################
[[ $EUID -ne 0 ]] && echo "not root!" && exec sudo "$0" "$@"
##############################INFO######################################################################
msg_ok() { echo -e "\e[1;42m $1 \e[0m";}
msg_err() { echo -e "\e[1;41m $1 \e[0m";}
msg_inf() { echo -e "\e[1;34m$1\e[0m";}
echo
msg_inf		'           ___    _   _   _  ';
msg_inf		' \/ __ | |  | __ |_) |_) / \ ';
msg_inf		' /\    |_| _|_   |   | \ \_/ ';
echo
##################################Variables#############################################################
XUIDB="/etc/x-ui/x-ui.db";domain="";UNINSTALL="x";INSTALL="n";PNLNUM=0;CFALLOW="off";NOPATH="";xuiVer=""
##################################Random Port and Path #################################################
Pak=$(command -v apt||echo dnf)
RNDSTR=$(tr -dc A-Za-z0-9 </dev/urandom | head -c "$(shuf -i 6-12 -n 1)")
while true; do 
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
	nc -z 127.0.0.1 "$PORT" &>/dev/null || break
done
################################Get arguments###########################################################
while [ "$#" -gt 0 ]; do
  case "$1" in
    -install) INSTALL="$2"; shift 2;;
    -panel) PNLNUM="$2"; shift 2;;
	-xuiver) xuiVer="$2"; shift 2;;
    -subdomain) domain="$2"; shift 2;;
    -cdn) CFALLOW="$2"; shift 2;;
    -uninstall) UNINSTALL="$2"; shift 2;;
    *) shift 1;;
  esac
done
##############################Uninstall#################################################################
UNINSTALL_XUI(){
	printf 'y\n' | x-ui uninstall
	for i in nginx python3-certbot-nginx tor; do
		$Pak -y remove $i
	done
	crontab -l | grep -v "nginx\|certbot\|x-ui\|cloudflareips" | crontab 
}
if [[ ${UNINSTALL} == *"y"* ]]; then
	UNINSTALL_XUI	
	clear && msg_ok "Completely Uninstalled!" && exit 1
fi
##############################Domain Validations########################################################
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
if [[ ${INSTALL} == *"y"* ]]; then
	$Pak -y update
	for i in epel-release cronie psmisc unzip curl nginx certbot python3-certbot-nginx sqlite sqlite3 tor; do
		$Pak -y install $i
	done
	systemctl daemon-reload
 	systemctl enable nginx.service
  	systemctl enable tor.service
   	systemctl enable cron.service > /dev/null 2>&1
   	systemctl enable crond.service > /dev/null 2>&1
	systemctl restart cron crond > /dev/null 2>&1
	systemctl start nginx
   	systemctl start tor
fi
###############################Stop nginx#############################################################
sudo nginx -s stop 2>/dev/null
sudo systemctl stop nginx 2>/dev/null
sudo fuser -k 80/tcp 80/udp 443/tcp 443/udp 2>/dev/null
##################################GET SERVER IPv4-6#####################################################
IP4_REGEX="^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"
IP6_REGEX="([a-f0-9:]+:+)+[a-f0-9]+"
IP4=$(ip route get 8.8.8.8 2>&1 | grep -Po -- 'src \K\S*')
IP6=$(ip route get 2620:fe::fe 2>&1 | grep -Po -- 'src \K\S*')
[[ $IP4 =~ $IP4_REGEX ]] || IP4=$(curl -s ipv4.icanhazip.com);
[[ $IP6 =~ $IP6_REGEX ]] || IP6=$(curl -s ipv6.icanhazip.com);
##############################Install SSL###############################################################
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
events {worker_connections 2048;}
http{
	gzip on;sendfile on;tcp_nopush on;
	types_hash_max_size 4096;
	default_type application/octet-stream;
	include /etc/nginx/*.types;
	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;
	}
EOF

rm -f "/etc/nginx/cloudflareips.sh"
cat << 'EOF' >> /etc/nginx/cloudflareips.sh
#!/bin/bash
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
if [[ ${CFALLOW} == *"on"* ]]; then
	CF_IP="";
	else	
	CF_IP="#";
fi
######################################## add_slashes /webBasePath/ #####################################
add_slashes() {
    [[ "$1" =~ ^/ ]] || set -- "/$1"
    [[ "$1" =~ /$ ]] || set -- "$1/"
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
	PANEL=( "https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh"
		"https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh"
	)

	printf 'n\n' | bash <(wget -qO- "${PANEL[$PNLNUM]}")
 
	if ! systemctl is-enabled --quiet x-ui; then
		systemctl daemon-reload
		systemctl enable x-ui.service
	fi	
 
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
	if [ "$RNDSTR" == "/" ]; then
		NOPATH="#"
	fi	
	if [[ -z "${PORT}" ]] || ! [[ "${PORT}" =~ ^-?[0-9]+$ ]]; then
		PORT="2053"
  	fi
else
	PORT="2053"
	RNDSTR="/";	NOPATH="#";
	XUIUSER="admin";XUIPASS="admin";
fi
#################################Nginx Config###########################################################
cat > "/etc/nginx/sites-available/$MainDomain" << EOF
server {
	server_tokens off;
	server_name $MainDomain *.$MainDomain;
	listen 80;
	listen 443 ssl;
	listen [::]:80;
	listen [::]:443 ssl;
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
	error_page 400 401 402 403 500 501 502 503 504 =404 /404;
	proxy_intercept_errors on;
	#X-UI Admin Panel
	location $RNDSTR {
		proxy_redirect off;
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:$PORT;
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
	$CF_IP if (\$cloudflare_ip != 1) {return 404;}
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
##################################Check Nginx status####################################################
if [[ -f "/etc/nginx/sites-available/$MainDomain" ]]; then
	unlink "/etc/nginx/sites-enabled/default" >/dev/null 2>&1
	rm -f "/etc/nginx/sites-enabled/default" "/etc/nginx/sites-available/default"
	ln -fs "/etc/nginx/sites-available/$MainDomain" "/etc/nginx/sites-enabled/" 2>/dev/null
fi

if ! systemctl start nginx > /dev/null 2>&1 || ! nginx -t &>/dev/null || nginx -s reload 2>&1 | grep -q error; then
	pkill -9 nginx || killall -9 nginx
	nginx -c /etc/nginx/nginx.conf
	nginx -s reload
fi

######################cronjob for ssl/reload service/cloudflareips######################################
crontab -l | grep -v "nginx\|certbot\|x-ui\|cloudflareips" | crontab -
(crontab -l 2>/dev/null; echo "@daily x-ui restart > /dev/null 2>&1 && systemctl reload tor;") | crontab -
(crontab -l 2>/dev/null; echo "@daily nginx -s reload 2>&1 | grep -q error && $(pkill -9 nginx;nginx -c /etc/nginx/nginx.conf;nginx -s reload);") | crontab -
(crontab -l 2>/dev/null; echo "@weekly bash /etc/nginx/cloudflareips.sh > /dev/null 2>&1;") | crontab -
(crontab -l 2>/dev/null; echo '@monthly certbot renew --nginx --force-renewal --non-interactive --post-hook "nginx -s reload" > /dev/null 2>&1;') | crontab -
##################################Show Details##########################################################
x-ui start > /dev/null 2>&1

if systemctl is-active --quiet x-ui || [ -e /etc/systemd/system/x-ui.service ]; then
	clear
	printf '0\n' | x-ui | grep --color=never -i ':'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	nginx -T | grep -i 'ssl_certificate\|ssl_certificate_key'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	certbot certificates | grep -i 'Path:\|Domains:\|Expiry Date:'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	[[ -n $IP4 ]] && [[ "$IP4" =~ $IP4_REGEX ]] && msg_inf "IPv4: http://$IP4:$PORT$RNDSTR"
	[[ -n $IP6 ]] && [[ "$IP6" =~ $IP6_REGEX ]] && msg_inf "IPv6: http://[$IP6]:$PORT$RNDSTR"
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	msg_inf "X-UI Secure Panel: https://${domain}${RNDSTR}\n"
	echo "Username: $XUIUSER"
	echo "Password: $XUIPASS"
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	msg_inf "Please Save this Screen!!"	
else
	nginx -t && printf '0\n' | x-ui | grep --color=never -i ':'
	msg_err "X-UI-PRO : Installation error..."
fi
#################################################N-joy##################################################
