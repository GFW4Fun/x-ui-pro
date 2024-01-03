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
- Nginx with anti-exploit, keepalive=on, cache=off
- Random 150+ fake template!
  
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖

**Install Panel**:dvd::package:

```
bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -install yes -panel 1
```
> -panel 0> FranzKafkaYu 1> MHSanaei 2> alireza0
> 
> For the additional subdomain, New A,AAAA[VPSIP] Recorde , no any config in vps!!!
>
> SSL works for (yourdomain.com, *.yourdomain.com)
>
> No need to on/off CDN, during installation
>
**Add more domains**:heavy_plus_sign:	
```
bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -subdomain sub.newdomain.com
```

**Random fake html site**:earth_asia:	
```
bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/randomfakehtml.sh)
```

**Uninstall**:x:
```
bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -uninstall yes
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
> bash > x-ui
> 
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/warp.png)
![](https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/xui-warp.png)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
### Cloudflare Find Good IP (VPN off❗ during scanning)
<h6>CCF IP Range: https://www.cloudflare.com/ips/</h6>
<h6>CF IP Scanner: https://vfarid.github.io/cf-ip-scanner/ | https://cloudflare-scanner.vercel.app | https://ircfspace.github.io/scanner/</h6>

##
[![Star History Chart](https://api.star-history.com/svg?repos=GFW4Fun/x-ui-pro)](https://star-history.com/#GFW4Fun/x-ui-pro)
