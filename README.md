## X-Ui-Pro (XRAY-UI + Nginx + WARP + TOR + Psiphon) :octocat:	:open_file_folder:	
### x-ui-pro is an open-source project that provides an auto-installation script for a lightweight and secure web proxy server. It combines the features of xray-ui, warp, tor and nginx to offer a comprehensive solution for bypassing internet restrictions.

- Handle **WebSocket/GRPC/HttpUgrade/SplitHttp** via **nginx**.
- Supports multiple users and configurations via port **443**
- Install multiple domains with one a server/panel
- More security and low detection with nginx
- Auto SSL Renew, Reload Daily Services
- Compatible with Cloudflare CDN/IP
- Random 150+ fake HTML template!
- Debian/Ubuntu/CentOS/Fedora Linux!
##

**Install X-UI-PRO**:dvd::package:

```
sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -install yes -panel 1 -cdn off"
```

<details><summary>Cloudflare users</summary>
 
**Cloudflare users > -cdn on > Domain<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">ON**
 
**SSL Support** (yourdomain.com, *.yourdomain.com)

**For add new subdomain, just add a new record A,AAAA[IP] in domain dns management! no need to reinstall the panel!**
</details>
<details><summary>Installation arguments</summary>

 **PanelType**
 ```
 -panel 0 (alireza) 1 (MHSanaei)
```

**Random FakeSite**:earth_asia:	
```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/randomfakehtml.sh)"
```

**Uninstall X-UI-PRO**:x:
```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -uninstall yes"
```
</details>

➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Server Configuration :wrench:🐧⚙️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/Config_XUI_ADMIN_4.jpg)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/grpc_config_format.jpg)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Client Configuration :white_check_mark:	:computer:🔌
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/XUI_CONFIG_XRAY_CLIENT_EDIT2.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable WARP<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34"> TOR 🧅 (Fix Google&ChatGPT Forbidden/Hide VPS IP)
#### WARP☁️> XUI > Xray Configs > Outbounds > WARP > Create > Add > Save Restart!
#### TOR 🧅> XUI > Xray Configs > Outbounds > Add Outbound > Protocol:Socks > Tag:tor > Address:Port 127.0.0.1:9050 > Add > Save Restart!
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor.jpg)
#### Connect Config(Inbound) to WARP/WARP+/TOR/Psiphon(Outbound):
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor3.jpg)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Checking Config/Port from inside the VPS (Internal)
#### Example: Check TOR/Psiphon/WARP on your server!
```
# Your current IP from TOR
curl --socks5-hostname 127.0.0.1:9050 checkip.amazonaws.com

# Your current IP from Psiphon
curl --socks5-hostname 127.0.0.1:1081 checkip.amazonaws.com

# Your current IP from WARP
curl --socks5-hostname 127.0.0.1:8086 checkip.amazonaws.com
```
#### If return VPS/WARP/TOR IP Means the port is active and healthy
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable Subscription :link:
#### XUI Panel > Panel Setting > Subscription > Enable Service (Don't change /sub/ /json/)
#### XUI Panel > Inbounds > General Actions > Export All URLs - Subscriptions
#### In the displayed address, change `  :  to  /  `
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
### Please Star ⭐ Thank you!

