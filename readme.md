### X-Ui-Pro (XrayWebUi + v2rayWebUi + Nginx + WARP + TOR + Psiphon) :rocket:
x-ui-pro is an open-source project that provides an auto-installation script for a lightweight and secure web proxy server. It combines the features of xray-ui, v2rayA-ui, warp, psiphon tor and nginx to offer a comprehensive solution (Many protocols and tools) for bypassing internet restrictions.

- Handle **WebSocket/GRPC/HttpUgrade** via **nginx**.
- Supports multiple users and config via port **443**
- Install multiple domains with one a server/panel
- More security and low detection with nginx
- Auto SSL Renew, Reload Daily Services
- Compatible with Cloudflare CDN/IP
- Random 170 fake HTML template!
- Tor/Psiphon country changer
- 🔜 v2rayA Web UI 🆕
- Only Linux Server
##

**Install X-UI-PRO**:dvd::package:

```
sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -panel 1 -cdn off"
```

<details><summary>:point_right:Cloudflare users :arrow_heading_down:</summary>
 
 ##
 
**Cloudflare users > -cdn on > Domain<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">ON**
 
**SSL Support** (yourdomain.com, *.yourdomain.com)

**For add new subdomain, just add a new record A,AAAA[IP] in domain dns management! no need to reinstall the panel!**
</details>
<details><summary>:point_right:Installation arguments :arrow_heading_down:</summary>
 
##
 
**Random FakeSite**:earth_asia:	
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -RandomTemplate yes
```

**Uninstall X-UI-PRO**:x:
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -Uninstall yes
```

**Enable Psiphon in WARP(Custom Country) <img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">+<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/psiphon.gif" width="15">**
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -WarpCfonCountry US
```

**Enable Psiphon in WARP(Random Country)🌐🎲**
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -WarpCfonCountry XX
```

**Tor Custom Country🧅🌍**
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -TorCountry US
```

**Tor Random Country 🧅🎲**
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -TorCountry XX
```

**Add LicenseKey to WARP<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">🔑**
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -WarpCfonCountry XX -WarpLicKey xxxx-xxxx-xxxx
```

**Disable WarpPsiphon and WARP CleanKey❌**
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -CleanKeyCfon yes
```


**Only > Optimize the Network, SSH & System Limits!🚀🔥🛠️**
```
bash <(wget -qO- raw.githubusercontent.com/hawshemi/Linux-Optimizer/main/linux-optimizer.sh)
```


**Other arguments:☢️**
```
# Install xui type: -panel 0 > Alireza0  1 > MHSanaei 2 > FranzKafkaYu
```

Valid🚩Country🌍 AT BE BG BR CA CH CZ DE DK EE ES FI FR GB HR HU IE IN IT JP LV NL NO PL PT RO RS SE SG SK UA US

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
#### v2rayA⚡🇻> XUI > Xray Configs > Outbounds > Add Outbound > Protocol:Socks > Tag:v2rayA > Address:Port 127.0.0.1:20170 > Add > Save Restart!

![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor.jpg)
#### Connect Config(Inbound) to WARP/WARP+/TOR/Psiphon(Outbound): :link:
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor3.jpg)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Checking TOR/Psiphon/WARP/v2rayA on your server (Internal)🔄
```
for port in 9050 8086 20170; do curl --socks5-hostname 127.0.0.1:$port https://ipapi.co/json/; done
```
## Enable Subscription :link:
#### XUI Panel > Panel Setting > Subscription > Enable Service (Don't change /sub/ /json/)
#### XUI Panel > Inbounds > General Actions > Export All URLs - Subscriptions
#### In the displayed address, change `  :  to  /  ` ✏️
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable UFW :no_entry_sign: Firewall (Prevent direct access to x-ui-xray ports)
```
sudo $(command -v apt || echo dnf) -y install ufw && ufw reset && echo ssh ftp http https mysql dns | xargs -n 1 sudo ufw allow && sudo ufw enable
```
## Cloudflare Find Good IP (VPN off❗ during scanning)
Cloudflare IP Ranges: https://www.cloudflare.com/ips/

Cloudflare IP Scanner: [vfarid](https://vfarid.github.io/cf-ip-scanner/) | [goldsrc](https://cloudflare-scanner.vercel.app) | [ircfspace](https://ircfspace.github.io/scanner/) | [drunkleen](https://drunkleen.github.io/ip-scanner/) | [cloudflare-v2ray-scanner](https://cloudflare-v2ray.vercel.app/)
##
### Special thanks to xray and xui developers :heart:

