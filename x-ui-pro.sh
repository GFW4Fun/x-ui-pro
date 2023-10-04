#!/bin/bash
############### x-ui-pro v1.0 @ github.com/GFW4Fun ##############
[[ $EUID -ne 0 ]] && echo "Run as root!" && exit 1
if [[ -f /etc/redhat-release ]]; then Pak="yum"
elif grep -Eqi "debian" /etc/issue; then Pak="apt"
elif grep -Eqi "ubuntu" /etc/issue; then Pak="apt"
elif grep -Eqi "centos|red hat|redhat" /etc/issue; then Pak="yum"
elif grep -Eqi "debian|raspbian" /proc/version; then Pak="apt"
elif grep -Eqi "ubuntu" /proc/version; then Pak="apt"
elif grep -Eqi "centos|red hat|redhat" /proc/version; then Pak="yum"
fi
################################Msg#################################
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
echo
echo " ##     ##         ##     ## ####         ########  ########   ####### ";
echo "  ##   ##          ##     ##  ##          ##     ## ##     ## ##     ## ";
echo "   ## ##           ##     ##  ##          ##     ## ##     ## ##     ## ";
echo "    ###    ####### ##     ##  ##  ####### ########  ########  ##     ## ";
echo "   ## ##           ##     ##  ##          ##        ##   ##   ##     ## ";
echo "  ##   ##          ##     ##  ##          ##        ##    ##  ##     ## ";
echo " ##     ##          #######  ####         ##        ##     ##  ####### ";
echo
#####################Random String and Port ####################################
RNDSTR=$(tr -dc A-Za-z0-9 </dev/urandom | head -c "$(shuf -i 6-12 -n 1)")
while true; do 
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break
    fi
done
################################Get arguments########################
XUIDB="/etc/x-ui/x-ui.db"
domain=""
UNINSTALL="x"
INSTALL="n"
PNLNUM=0
while [ "$#" -gt 0 ]; do
  case "$1" in
    -install) INSTALL="$2"; shift 2;;
    -panel) PNLNUM="$2"; shift 2;;
    -subdomain) domain="$2"; shift 2;;
    -uninstall) UNINSTALL="$2"; shift 2;;
    *) shift 1;;
  esac
done
##############################Uninstall##############################
UNINSTALL_XUI(){
	printf 'y\n' | x-ui uninstall
	rm -rf "/etc/x-ui/" "/usr/local/x-ui/" "/usr/bin/x-ui/"
	$Pak -y remove nginx nginx-common nginx-core nginx-full python3-certbot-nginx
	$Pak -y purge nginx nginx-common nginx-core nginx-full python3-certbot-nginx
	$Pak -y autoremove
	$Pak -y autoclean
	rm -rf "/var/www/html/" "/etc/nginx/" "/usr/share/nginx/" 
}
if [[ ${UNINSTALL} == *"y"* ]]; then
	UNINSTALL_XUI	
	clear && msg_ok "Completely Uninstalled!" && exit 1
fi
##############################Domain Validations######################
while true; do
	domain=$(echo "$domain" 2>&1 | tr -d '[:space:]' )
	SubDomain=$(echo "$domain" 2>&1 | sed 's/^[^ ]* \|\..*//g')
	MainDomain=$(echo "$domain" 2>&1 | sed 's/.*\.\([^.]*\..*\)$/\1/')
	if [[ -n "$domain" ]] &&  [[ "${SubDomain}.${MainDomain}" == "${domain}" ]] ; then
		if [[ -n $(host "$domain" 2>/dev/null | grep -v NXDOMAIN) ]]; then
			break
		fi
	fi
	echo -en "${Blue}Enter available subdomain${Font} (${Yellow}sub.domain.tld${Font}): " && read domain 
done
###############################Install Packages#############################
if [[ ${INSTALL} == *"y"* ]]; then
	$Pak -y update
	$Pak -y install nginx-full certbot python3-certbot-nginx sqlite3 
	systemctl enable --now nginx
fi
#########################Install nginx Config###############################
systemctl stop nginx 
fuser -k 80/tcp 80/udp 443/tcp 443/udp 2>/dev/null
if [[ ! -f "/etc/letsencrypt/live/${MainDomain}/privkey.pem" ]]; then
	certbot certonly --standalone --non-interactive --force-renewal --agree-tos --register-unsafely-without-email --cert-name "$MainDomain" -d "$domain"
else
	msg_ok "$MainDomain SSL Certificate is exist!"
fi
sleep 3
if [[ ! -f "/etc/letsencrypt/live/${MainDomain}/privkey.pem" ]]; then
	msg_err "$MainDomain SSL certificate could not be generated, Maybe the domain or IP domain is invalid!" && exit 1
fi

cat > "/etc/nginx/sites-available/$MainDomain" << EOF
server {
	server_name ~^((?<subdomain>.*)\.)?(?<domain>[^.]+)\.(?<tld>[^.]+)\$;
	listen 80;
	listen 443 ssl http2;
	listen [::]:80 ipv6only=on;
	listen [::]:443 ssl http2 ipv6only=on;
	http2_push_preload on;
	index index.html index.htm index.php index.nginx-debian.html;
	root /var/www/html/;
	ssl_protocols TLSv1.2 TLSv1.3;
	ssl_certificate /etc/letsencrypt/live/$MainDomain/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/$MainDomain/privkey.pem;
	if (\$host !~* ^(.+\.)?$MainDomain\$ ) { return 444; }
	if (\$request_method !~ ^(GET|HEAD|POST|PUT|DELETE)\$ ) { return 444; }
	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
	location ~* (?:\.(?:db|json|pub|pem|config|conf|inf|ini|inc|bak|sql|log|py|sh|passwd|pwd|cgi|lua)|~)\$ { deny all; }
	location ~* (\`|"|'|0x00|%0A|%0D|%27|%22|%3C|%3E|%00|%60|%24&x|%0|%A|%B|%C|%D|%E|%F|127\.0) { deny all; }
	location ~* "(&pws=0|_vti_|\(null\)|\{\$itemURL\}|echo(.*)kae|etc/passwd|eval\(|self/environ)" { deny all; }
	location ~ "(\\|\.\.\.|\.\./|~|\`|<|>|\|)" { deny all; }
	location ~* [a-zA-Z0-9_]=(\.\.//?)+ { deny all; }
	location ~* [a-zA-Z0-9_]=/([a-z0-9_.]//?)+ { deny all; }
	location /$RNDSTR/ {
		proxy_redirect off;
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:$PORT;
   }
	location ~ ^/(?<fwdport>\d+)/(?<fwdpath>.*)\$ {
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
		if (\$content_type = "application/grpc") {
			grpc_pass grpc://127.0.0.1:\$fwdport;
			break;
		}
		if (\$http_upgrade = "websocket") {
			proxy_pass http://127.0.0.1:\$fwdport/\$fwdport/\$fwdpath;
			break;
		}	
	}
	location / { try_files \$uri \$uri/ =404; }
}
EOF
###################################Enable Site###############################
if [[ -f "/etc/nginx/sites-available/$MainDomain" ]]; then
	unlink /etc/nginx/sites-enabled/default 2>/dev/null
	ln -s "/etc/nginx/sites-available/$MainDomain" /etc/nginx/sites-enabled/
	systemctl start nginx 
else
	msg_err "$MainDomain nginx config not exist!" && exit 1
fi
###################################Update Db##################################
UPDATE_XUIDB(){
if [[ -f $XUIDB ]]; then
	sqlite3 $XUIDB <<EOF
	DELETE FROM "settings" WHERE "key"="webPort";
	DELETE FROM "settings" WHERE "key"="webCertFile";
	DELETE FROM "settings" WHERE "key"="webKeyFile";
	DELETE FROM "settings" WHERE "key"="webBasePath";
	INSERT INTO "settings" ("key", "value") VALUES ("webPort",  "${PORT}");
	INSERT INTO "settings" ("key", "value") VALUES ("webCertFile",  "");
	INSERT INTO "settings" ("key", "value") VALUES ("webKeyFile", "");
	INSERT INTO "settings" ("key", "value") VALUES ("webBasePath", "/${RNDSTR}/");
EOF
else
	msg_err "x-ui.db file not exist! Maybe x-ui isn't installed." && exit 1;
fi
}
###################################Install Panel#########################
if systemctl is-active --quiet x-ui; then
	UPDATE_XUIDB
	x-ui restart
else
	PANEL=("https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install_en.sh"
		"https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh"
		"https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh")

	printf 'n\n' | bash <(wget -qO- "${PANEL[$PNLNUM]}")
	UPDATE_XUIDB
	if ! systemctl is-enabled --quiet x-ui; then
		systemctl daemon-reload
		systemctl enable x-ui.service
	fi
	x-ui restart
fi
######################cronjob for ssl and reload service##################
crontab -l | grep -v "certbot\|x-ui" | crontab -
(crontab -l 2>/dev/null; echo '0 1 * * * x-ui restart && nginx -s reload') | crontab -
(crontab -l 2>/dev/null; echo '0 0 1 * * certbot renew --nginx --force-renewal --non-interactive --post-hook "nginx -s reload"') | crontab -
##################################Show Details############################
XUIPORT=$(sqlite3 -list $XUIDB 'SELECT "value" FROM settings WHERE "key"="webPort" LIMIT 1;' 2>&1)
if systemctl is-active --quiet x-ui && [[ $XUIPORT -eq $PORT ]]; then clear
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	printf '0\n' | x-ui | grep --color=never -i ':'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	nginx -T | grep -i 'ssl_certificate\|ssl_certificate_key'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	certbot certificates | grep -i 'Path:\|Domains:\|Expiry Date:'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	msg_inf "\nX-UI Admin Panel: https://${domain}/${RNDSTR}\n"
	sqlite3 -box $XUIDB 'SELECT "username","password" FROM users;'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
else
	nginx -t && printf '0\n' | x-ui | grep --color=never -i ':'
	msg_err "sqlite and x-ui to be checked, try on a new clean linux! "
fi
#####N-joy##### 
