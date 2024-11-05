### X-Ui-Pro (XRAY-UI + Nginx + WARP + TOR + Psiphon + WireGuard) :rocket:
x-ui-pro is an open-source project that provides an auto-installation script for a lightweight and secure web proxy server. It combines the features of xray-ui, warp, tor and nginx to offer a comprehensive solution for bypassing internet restrictions.

- Handle **WebSocket/GRPC/HttpUgrade/SplitHttp** via **nginx**.
- Supports multiple users and configurations via port **443**
- Install multiple domains with one a server/panel
- More security and low detection with nginx
- Auto SSL Renew, Reload Daily Services
- Compatible with Cloudflare CDN/IP
- Random 170 fake HTML template!
- Debian/Ubuntu/CentOS/Fedora Linux!
##

**Install X-UI-PRO**:dvd::package:

```
sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -panel 1 -cdn off"
```

<details><summary>Cloudflare users :small_red_triangle_down:</summary>
 
 ##
 
**Cloudflare users > -cdn on > Domain<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">ON**
 
**SSL Support** (yourdomain.com, *.yourdomain.com)

**For add new subdomain, just add a new record A,AAAA[IP] in domain dns management! no need to reinstall the panel!**
</details>
<details><summary>Installation arguments :small_red_triangle_down:</summary>
 
##
 
**Random FakeSite**:earth_asia:	
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -RandomTemplate yes
```

**Uninstall X-UI-PRO**:x:
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -Uninstall yes
```

**Enable Psiphon in WARP(Custom Country) <img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">+<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/psiphon.gif" width="15">**
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -WarpCfonCountry US
```

**Enable Psiphon in WARP(Random Country)🌐🎲**
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -WarpCfonCountry XX
```

**Tor Custom Country🧅🌍**
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -TorCountry US
```

**Tor Random Country 🧅🎲**
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -TorCountry XX
```

**Add LicenseKey to WARP<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">🔑**
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -WarpLicKey xxxx-xxxx-xxxx
```

**Disable WarpPsiphon and WARP CleanKey❌**
```
bash <(wget -qO- cdn.jsdelivr.net/gh/GFW4Fun/x-ui-pro/x-ui-pro.sh) -CleanKeyCfon yes
```

**Other arguments:☢️**
```
# Install xui type: -panel 0 > Alireza0  1 > MHSanaei 2 > FranzKafkaYu
```

</details>

➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Server Configuration :wrench:🐧⚙️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/Config_XUI_ADMIN_4.jpg)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/grpc_config_format.jpg)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Client Configuration 👨‍💻📱✏️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/XUI_CONFIG_XRAY_CLIENT_EDIT2.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable WARP<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34"> TOR 🧅 (Fix Google&ChatGPT Forbidden/Hide VPS IP)
#### WARP☁️> XUI > Xray Configs > Outbounds > WARP > Create > Add > Save Restart!
#### WARP-Plus☁️> XUI > Xray Configs > Outbounds > Add Outbound > Protocol:Socks > Tag:warp+ > Address:Port 127.0.0.1:8086 > Add > Save Restart!
#### TOR 🧅> XUI > Xray Configs > Outbounds > Add Outbound > Protocol:Socks > Tag:tor > Address:Port 127.0.0.1:9050 > Add > Save Restart!
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor.jpg)
#### Connect Config(Inbound) to WARP/WARP+/TOR/Psiphon(Outbound): :link:
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor3.jpg)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Checking Config/Port inside VPS (Internal)🔄
#### Example: Check TOR/Psiphon/WARP on your server!
```
#TOR
curl -s --socks5-hostname 127.0.0.1:9050 "http://ip-api.com/json/" | jq .

#WARP/Psiphon
curl -s --socks5-hostname 127.0.0.1:8086 "http://ip-api.com/json/" | jq .

```
#### If return details, The port is active and healthy📶✅

➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable Subscription :link:
#### XUI Panel > Panel Setting > Subscription > Enable Service (Don't change /sub/ /json/)
#### XUI Panel > Inbounds > General Actions > Export All URLs - Subscriptions
#### In the displayed address, change `  :  to  /  ` ✏️
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable UFW :no_entry_sign: Firewall (Prevent direct access to x-ui-xray ports)
```
apt update && apt install ufw
ufw reset && ufw allow ssh && ufw allow ftp && ufw allow http && ufw allow https
ufw enable && ufw reload && ufw status
```
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Cloudflare Find Good IP (VPN off❗ during scanning)
Cloudflare IP Ranges: https://www.cloudflare.com/ips/

Cloudflare IP Scanner: [vfarid](https://vfarid.github.io/cf-ip-scanner/) | [goldsrc](https://cloudflare-scanner.vercel.app) | [ircfspace](https://ircfspace.github.io/scanner/) | [drunkleen](https://drunkleen.github.io/ip-scanner/) | [cloudflare-v2ray-scanner](https://cloudflare-v2ray.vercel.app/)
##
### Special thanks to xray and xui developers :heart:

