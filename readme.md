### XUI-PRO (Xray-UI/v2rayA/Nginx/WARP/TOR/Psiphon) :rocket:
x-ui-pro is an open-source project that provides an auto-installation script for a lightweight and secure web proxy server. It combines the features of x-ui, v2rayA, warp, psiphon tor and nginx to offer a comprehensive solution (Many protocols and tools) for bypassing internet restrictions.

- Handle **WebSocket/GRPC/HttpUgrade** via **nginx**.
- Supports multiple users and config via port **443**
- Install multiple domains with one a server/panel
- More security and low detection with nginx
- Auto SSL Renew, Reload Daily Services
- X-UI Xray / V2rayA  Admin Web Panel
- Compatible with Cloudflare CDN/IP
- Random 170 fake HTML template!
- Tor/Psiphon country changer
- Only Linux Server
 
##

**Install XUI-PRO**:dvd::package:

```
sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -panel 1 -xuiver last -cdn off"
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

**Valid🚩Country🌍🆔**
```
AT BE BG BR CA CH CZ DE DK EE ES FI FR GB HR HU IE IN IT JP LV NL NO PL PT RO RS SE SG SK UA US
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

**Enable UFW :no_entry_sign: Firewall (Prevent direct access to xui-xray-v2ray ports)**
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -ufw on
```

**Other install arguments:☢️**
```
-panel 0 > Alireza0_XUI  1 > MHSanaei_XUI 2 > FranzKafkaYu_XUI
```
```
-xuiver 2.4.7  # XUI Panel version (default is 'last' version)
```
```
-country ru,cn,de,fi,us (Only users from these countries are allowed to connect) ## -country xx (All countries are allowed) !works with -cdn on / Cloudflare On!
```
```
-secure yes   # Enable Nginx auth + Block Bad UA [xray,v2ray,go-http-client,vpn,proxy,tunnel,bot...] (Only advanced users) 
```
Secure mode only works with [GFW-knocker/Xray-core](https://github.com/GFW-knocker/Xray-core) / [GFW-knocker/MahsaNG](https://github.com/GFW-knocker/MahsaNG) for client!

Or to clean|change this phrase "Go-http-client/x" from the xray/v2ray/v2fly core
</details>

➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Server Configuration :wrench:🐧⚙️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/Config_XUI_ADMIN_4.jpg)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/grpc_config_format.jpg)
### Client Configuration 👨‍💻📱✏️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/XUI_CONFIG_XRAY_CLIENT_EDIT2.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable WARP<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34"> TOR 🧅 (Fix Google&ChatGPT Forbidden/Hide VPS IP)
#### XUI > Xray Configs > Outbounds > Add Outbound ➕💾👇
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor02.jpg)
#### Connect Config(Inbound) to WARP/WARP+/TOR/Psiphon/v2rayA (Outbound): :link:
#### XUI > Xray Configs > Routing Rules > Add Rule ➕💾👇
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor3.jpg)
#### v2rayA Panel Settings (v2rayA suggested as Outbound and supports the subscription links):⚙️👇
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/v2rayadminpanel2.jpg)
## Enable XUI Subscription :link:
XUI Panel > Panel Setting > Subscription > Enable Service (Don't change /sub/ /json/)

XUI Panel > Inbounds > General Actions > Export All URLs - Subscriptions

In the displayed address, change `  :  to  /  ` ✏️

## Useful Links :fire: :link:
```
_________________________________________________________________ IP Tools
https://www.cloudflare.com/ips/
https://cloudflare-scanner.vercel.app/
https://cloudflare-v2ray.vercel.app/
https://drunkleen.github.io/ip-scanner/
https://ircfspace.github.io/scanner/
https://vfarid.github.io/cf-ip-scanner/
https://www.ipaddressguide.com/cidr
https://codifyformatter.org/random-ip
https://github.com/ircfspace/tester
__________________________________________________________ Config Fragment
https://fragment.github1.cloud/
https://misaturo.github.io/Xray-Fragment-Configurator/
_____________________________________________________________ Config Tools
https://github.com/MrMohebi/xray-proxy-grabber-telegram
https://github.com/lilendian0x00/xray-knife
https://github.com/mheidari98/proxyUtil
https://github.com/RealCuf/VCG-Script
https://github.com/shabane/kamaji
______________________________________________________________ Free Config
https://github.com/mermeroo/V2RAY-and-CLASH-Subscription-Links
https://github.com/soroushmirzaei/telegram-configs-collector
https://github.com/mahdibland/V2RayAggregator/tree/master
https://github.com/barry-far/V2ray-Configs
https://github.com/ripaojiedian/freenode
https://github.com/Pawdroid/Free-servers
https://github.com/snakem982/proxypool
https://github.com/NiREvil/vless
```

##
### Special thanks to xray/xui/v2ray/singbox developers :heart:

