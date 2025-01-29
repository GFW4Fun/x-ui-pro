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
sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -panel 1 -xuiver last -cdn off -secure no -country xx"
```

<details><summary>:point_right:Cloudflare users :arrow_heading_down:</summary>
 
 ##
 
**<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">(-cdn on ) Access is only possible from the CDN IP.**

**🌍(-country cn,ru,us,de) Only connections from these countries are allowed. [xx = all]**

**🔒SSL Support:** (yourdomain.com, *.yourdomain.com) **To add a new subdomain, just create a new A record in your domain's DNS management. no need to reinstall the panel!**
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

To clean or change the phrase "Go-http-client/x" from the xray/v2ray/singbox core.
</details>

<details><summary>:point_right:Secure mode! :arrow_heading_down:</summary>
 
```
sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -panel 1 -xuiver last -cdn on -secure yes -country xx"
```
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -ufw on
```
```
bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -RandomTemplate yes
```
```
https://gfw4fun.github.io/xray_bulk_config_with_random_cdn_ip_range/
```
Secure mode only works with [GFW-knocker/Xray-core](https://github.com/GFW-knocker/Xray-core) / [GFW-knocker/MahsaNG](https://github.com/GFW-knocker/MahsaNG) for client!

 </details>
 
<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/hr.png" width="100%">

### Server Configuration :wrench:🐧⚙️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/Config_XUI_ADMIN_4.jpg)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/grpc_config_format.jpg)
### Client Configuration 👨‍💻📱✏️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/XUI_CONFIG_XRAY_CLIENT_EDIT2.png)
<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/hr.png" width="100%">

## Enable WARP<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34"> TOR 🧅 (Fix Google&ChatGPT Forbidden/Hide VPS IP)
#### XUI > Xray Configs > Outbounds > Add Outbound ➕💾👇
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor02.jpg)
#### Connect Config(Inbound) to WARP/WARP+/TOR/Psiphon/v2rayA (Outbound): :link:
#### XUI > Xray Configs > Routing Rules > Add Rule ➕💾👇
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor3.jpg)
#### v2rayA Panel Settings (v2rayA suggested as Outbound and supports the subscription links):⚙️👇
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/v2rayadminpanel2.jpg)
If you forget your password, run "v2raya-reset-password" to reset it (in ssh bash)

v2rayA the configuration directory is: /usr/local/etc/v2raya
## Enable XUI Subscription :link:
XUI Panel > Panel Setting > Subscription > Enable Service (Don't change /sub/ /json/)

XUI Panel > Inbounds > General Actions > Export All URLs - Subscriptions

In the displayed address, change `  :  to  /  ` ✏️
<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/hr.png" width="100%">

## Useful Tools :fire: :link:
[Bulk Config With Random CDN IP Range](https://gfw4fun.github.io/xray_bulk_config_with_random_cdn_ip_range/)

[Xray Merge Multi Config for Balancer](https://github.com/Surfboardv2ray/Xray-Load-Balancer)

[Xray Json Config Fragment for bypass firewall](https://misaturo.github.io/Xray-Fragment-Configurator/)

[Free Multi Clash/Xray/v2ray Sub link](https://raw.githubusercontent.com/mermeroo/V2RAY-and-CLASH-Subscription-Links/refs/heads/main/SUB%20LINKS)

##
### Special thanks to xray/xui/v2ray/singbox developers :heart:

