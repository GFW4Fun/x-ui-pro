## x-ui-pro (x-ui + nginx) :octocat:	:open_file_folder:	
- Auto Installation (lightweight)
- Compatible with Cloudflare
- Auto SSL renewal (cronjob)
- Auto-reload nginx and x-ui
- Multi-domain and sub-domain support
- Handle WebSocket and GRPC via nginx.
- Multi-user and config via port 443
- Access to x-ui panel via nginx
- Compatible with Debian 10+ and Ubuntu 20+
- More security and low detection with nginx
- Random 150+ fake template!
  
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖

**Install X-UI-PRO**:dvd::package:

```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -install yes -panel 0"
```
> -panel 0>alireza 1>MHSanaei 2>FranzKafkaYu
> 
> For the additional subdomain, New A,AAAA[VPSIP] Recorde , no any config in vps!!!
>
> SSL works for (yourdomain.com, *.yourdomain.com)
>
> No need to on/off CDN, during installation
>
**ADD New Domain**:heavy_plus_sign:	
```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -subdomain sub.newdomain.com"
```

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
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/admin_config.png)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/trojan_grpc_admin.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Client Configuration :white_check_mark:	:computer:🔌
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/client_config.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Fix Error 403 (Forbidden)❗️❗️ Google
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/error403Google.png)
#### X-UI Admin Panel > Xray Setting > Outbands > Add WARP > then...
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/xui-warp.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Cloudflare Find Good IP (VPN off❗ during scanning)
Cloudflare IP Ranges: https://www.cloudflare.com/ips/

Cloudflare IP Scanner: [vfarid](https://vfarid.github.io/cf-ip-scanner/) | [goldsrc](https://cloudflare-scanner.vercel.app) | [ircfspace](https://ircfspace.github.io/scanner/)

##
[![Star History Chart](https://api.star-history.com/svg?repos=GFW4Fun/x-ui-pro&type=Date)](https://github.com/GFW4Fun/x-ui-pro)

