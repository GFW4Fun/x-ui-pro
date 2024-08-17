#!/bin/bash
############### x-ui-pro v1.5.1 @ github.com/GFW4Fun ##############
[[ $EUID -ne 0 ]] && echo "not root!" && sudo su -
Pak=$(type apt &>/dev/null && echo "apt" || echo "yum")
msg_ok() { echo -e "\e[1;42m $1 \e[0m";}
msg_err() { echo -e "\e[1;41m $1 \e[0m";}
msg_inf() { echo -e "\e[1;34m$1\e[0m";}
echo;msg_inf '           ___    _   _   _  '	;
msg_inf		 ' \/ __ | |  | __ |_) |_) / \ '	;
msg_inf		 ' /\    |_| _|_   |   | \ \_/ '	; echo
RNDSTR=$(tr -dc A-Za-z0-9 </dev/urandom | head -c "$(shuf -i 6-12 -n 1)")
XUIDB="/etc/x-ui/x-ui.db";domain="";UNINSTALL="x";INSTALL="n";PNLNUM=0;CFALLOW="n"
while true; do 
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break
    fi
done
################################Get arguments########################
while [ "$#" -gt 0 ]; do
  case "$1" in
    -install) INSTALL="$2"; shift 2;;
    -panel) PNLNUM="$2"; shift 2;;
    -subdomain) domain="$2"; shift 2;;
    -ONLY_CF_IP_ALLOW) CFALLOW="$2"; shift 2;;
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
	crontab -l | grep -v "certbot\|x-ui\|cloudflareips" | crontab -
}
if [[ ${UNINSTALL} == *"y"* ]]; then
	UNINSTALL_XUI	
	clear && msg_ok "Completely Uninstalled!" && exit 1
fi
##############################Domain Validations######################
while true; do	
	if [[ ! -z "$domain" ]]; then
		break
	fi
	echo -en "Enter available subdomain (sub.domain.tld): " && read domain 
done

domain=$(echo "$domain" 2>&1 | tr -d '[:space:]' )
SubDomain=$(echo "$domain" 2>&1 | sed 's/^[^ ]* \|\..*//g')
MainDomain=$(echo "$domain" 2>&1 | sed 's/.*\.\([^.]*\..*\)$/\1/')

if [[ "${SubDomain}.${MainDomain}" != "${domain}" ]] ; then
	MainDomain=${domain}
fi
###############################Install Packages#############################
if [[ ${INSTALL} == *"y"* ]]; then
	$Pak -y update
	$Pak -y install curl nginx certbot python3-certbot-nginx sqlite3 
	systemctl daemon-reload && systemctl enable --now nginx
fi
systemctl stop nginx 
fuser -k 80/tcp 80/udp 443/tcp 443/udp 2>/dev/null
##############################Install SSL####################################
for D in `find /etc/letsencrypt/live -mindepth 1 -type d -exec basename {} \;`; do
	if [[ $D == "${MainDomain}" ]]; then
		certbot delete --non-interactive --cert-name ${MainDomain}
	fi       
done
 
certbot certonly --standalone --non-interactive --force-renewal --agree-tos --register-unsafely-without-email --cert-name "$MainDomain" -d "$domain"

if [[ ! -d "/etc/letsencrypt/live/${MainDomain}/" ]]; then
	msg_err "$MainDomain SSL could not be generated! Check Domain/IP Or Enter new domain!" && exit 1
fi
###########################################################################
IPV4_REGEX='^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'
IP6_REGEX='([a-f0-9:]+:+)+[a-f0-9]+'

IP4=$(ip route get 9.9.9.9 | grep -Po -- 'src \K\S*')
IP6=$(ip route get 2620:fe::fe | grep -Po -- 'src \K\S*')

if [[ "$IP4" != $IP4_REGEX ]]; then
	IP4=$(dig @resolver1.opendns.com A myip.opendns.com +short -4) 
fi
if [[ "$IP6" != $IP6_REGEX ]]; then
	IP6=$(dig @resolver1.opendns.com AAAA myip.opendns.com +short -6)
fi

if [[ "$IP4" != $IP4_REGEX ]]; then
	IP4=$(curl -s ipv4.icanhazip.com)
fi
if [[ "$IP6" != $IP6_REGEX ]]; then
	IP6=$(curl -s ipv6.icanhazip.com)
fi
################################# Access to configs only with cloudflare 
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
echo "real_ip_header X-Real-IP;" >> $CLOUDFLARE_REAL_IPS_PATH
echo "}" >> $CLOUDFLARE_WHITELIST_PATH
EOF
sudo bash "/etc/nginx/cloudflareips.sh" > /dev/null 2>&1;
if [[ ${CFALLOW} == *"y"* ]]; then
	CF_IP="if (\$cloudflare_ip != 1) {return 404;}";
	else	
	CF_IP="";
fi
###########################################################################
cat > "/etc/nginx/sites-available/$MainDomain" << EOF
server {
	server_name ~^((?<subdomain>.*)\.)?(?<domain>[^.]+)\.(?<tld>[^.]+)\$;
	listen 80;
	listen 443 ssl http2;
	listen [::]:80 ipv6only=on;
	listen [::]:443 ssl http2 ipv6only=on;
	index index.html index.htm index.php index.nginx-debian.html;
	root /var/www/html/;
	ssl_protocols TLSv1.2 TLSv1.3;
	ssl_certificate /etc/letsencrypt/live/$MainDomain/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/$MainDomain/privkey.pem;
	if (\$host !~* ^(.+\.)?$MainDomain\$ ) { return 403; }
	location /$RNDSTR/ {
		proxy_redirect off;
		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:$PORT;
	}
	location ~ ^/(?<fwdport>\d+)/(?<fwdpath>.*)\$ {
		$CF_IP
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
		if (\$content_type ~* "GRPC") {
			grpc_pass grpc://127.0.0.1:\$fwdport\$is_args\$args;
			break;
		}
		if (\$http_upgrade ~* "(WEBS|WSS|WS)") {
			proxy_pass http://127.0.0.1:\$fwdport\$is_args\$args;
			break;
	        }
		if (\$request_method ~* ^(PUT|POST|GET)\$) {
			proxy_pass http://127.0.0.1:\$fwdport\$is_args\$args;
			break;
		}	
	}
	location / { try_files \$uri \$uri/ =404; }
}
EOF
###################################Enable Site###############################
if [[ -f "/etc/nginx/sites-available/$MainDomain" ]]; then
	unlink /etc/nginx/sites-enabled/default 2>/dev/null
	ln -s "/etc/nginx/sites-available/$MainDomain" /etc/nginx/sites-enabled/ 2>/dev/null
	systemctl start nginx 
else
	msg_err "$MainDomain nginx config not exist!" && exit 1
fi
###################################Update Db##################################
UPDATE_XUIDB(){
if [[ -f $XUIDB ]]; then
	sqlite3 $XUIDB <<EOF
	DELETE FROM "settings" WHERE ( "key"="webPort" ) OR ( "key"="webCertFile" ) OR ( "key"="webKeyFile" ) OR ( "key"="webBasePath" ); 
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
	PANEL=( "https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh"
			"https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh"
			"https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install_en.sh"
		)

	printf 'n\n' | bash <(wget -qO- "${PANEL[$PNLNUM]}")
	UPDATE_XUIDB
	if ! systemctl is-enabled --quiet x-ui; then
		systemctl daemon-reload && systemctl enable x-ui.service
	fi
	x-ui restart
fi
######################cronjob for ssl and reload service##################
crontab -l | grep -v "certbot\|x-ui\|cloudflareips" | crontab -
(crontab -l 2>/dev/null; echo '@weekly bash /etc/nginx/cloudflareips.sh > /dev/null 2>&1;') | crontab -
(crontab -l 2>/dev/null; echo '0 1 * * * x-ui restart > /dev/null 2>&1 && nginx -s reload;') | crontab -
(crontab -l 2>/dev/null; echo '0 0 1 * * certbot renew --nginx --force-renewal --non-interactive --post-hook "nginx -s reload" > /dev/null 2>&1;') | crontab -
##################################Show Details############################
XUIPORT=$(sqlite3 -list $XUIDB 'SELECT "value" FROM settings WHERE "key"="webPort" LIMIT 1;' 2>&1)
if systemctl is-active --quiet x-ui && [[ $XUIPORT -eq $PORT ]]; then clear
	printf '0\n' | x-ui | grep --color=never -i ':'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	nginx -T | grep -i 'ssl_certificate\|ssl_certificate_key'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	certbot certificates | grep -i 'Path:\|Domains:\|Expiry Date:'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	if [[ -n $IP4 ]] && [[ "$IP4" =~ $IP4_REGEX ]]; then 
		msg_inf "IPv4: $IP4"	
	fi
	if [[ -n $IP6 ]] && [[ "$IP6" =~ $IP6_REGEX ]]; then 
		msg_inf "IPv6: $IP6"
	fi
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	msg_inf "X-UI Admin Panel: https://${domain}/${RNDSTR}\n"
 	echo -n "Username:  " && sqlite3 $XUIDB 'SELECT "username" FROM users;'
	echo -n "Password:  " && sqlite3 $XUIDB 'SELECT "password" FROM users;'
	msg_inf "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	msg_inf "Please Save this Screen!!"	
else
	nginx -t && printf '0\n' | x-ui | grep --color=never -i ':'
	msg_err "sqlite and x-ui to be checked, try on a new clean linux! "
fi
#####N-joy##### 
