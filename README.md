## X-ui-Pro (Xray-UI + Nginx + WARP + TOR) :octocat:	:open_file_folder:	
### x-ui-pro is an open-source project that provides an auto-installation script for a lightweight and secure web proxy server. It combines the features of xray-ui, warp, tor and nginx to offer a comprehensive solution for bypassing internet restrictions.

- Automatic installation and configuration of the x-ui panel, WARP, and Nginx
- Auto SSL_Renewal/ Daily reload nginx_xui_xray_warp_tor service
- Handle **WebSocket/GRPC/HttpUgrade/SplitHttp** via **nginx**.
- Supports multiple users and configurations via port **443**
- Install multiple domains with one a server/panel
- More security and low detection with nginx
- Compatible with Cloudflare CDN/IP
- Random 150+ fake HTML template!
- Linux Debian/Ubuntu/CentOS!

➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖

**Install X-UI-PRO**:dvd::package:

```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -install yes -panel 1 -ONLY_CF_IP_ALLOW no"
```
> 
> Recommended -ONLY_CF_IP_ALLOW yes + (Cloudflare<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">TURN ON) + SSL/TLS > Full
>
> Cloudflare > yourDomain > Network > gRPC <img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/TURNON.png" width="28">
> ##
> SSL Support (yourdomain.com, *.yourdomain.com) for new subdomain, just add a new record A,AAAA[IP] in domain dns management! no need to reinstall the
panel!
> 
> Do not change SubDomain for renew SSL❗
> ##
> -panel (0=alireza 1=MHSanaei 2=FranzKafkaYu)
> 
**Random Fake HTMLSite**:earth_asia:	
```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/randomfakehtml.sh)"
```

**Uninstall X-UI-PRO**:x:
```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -uninstall yes"
```

➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Server Configuration :wrench:🐧⚙️
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/Config_XUI_ADMIN_4.jpg)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/grpc_config_format.jpg)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Client Configuration :white_check_mark:	:computer:🔌
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/XUI_CONFIG_XRAY_CLIENT_EDIT2.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Enable WARP<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34"> & TOR 🧅 (Fix Google Error and Hide VPS IP)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/error403Google.png)
#### WARP☁️> XUI > Xray Configs > Outbounds > WARP > Create > Add > Save Restart!
#### TOR 🧅> XUI > Xray Configs > Outbounds > Add Outbound > Protocol:Socks > Tag:tor > Address:Port 127.0.0.1:9050 > Add > Save Restart!
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor.jpg)
#### Connect Config(Inbound) to WARP/TOR(Outbound):
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warptor3.jpg)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
## Checking Config/Port from inside the VPS (Internal)
#### Example: Check TOR on your server!
````curl --socks5-hostname 127.0.0.1:9050 checkip.amazonaws.com````
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

