## x-ui-pro (x-ui + nginx) :octocat:	:open_file_folder:	
- Auto Installation (lightweight)
- Auto SSL renewal / Daily reload Nginx X-ui
- Handle **WebSocket/GRPC/HttpUgrade/SplitHttp** via **nginx**.
- Multi-user and config via port **443**
- More security and low detection with nginx
- Compatible with Cloudflare
- Random 150+ fake template!
  
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖

**Install X-UI-PRO**:dvd::package:

```
sudo su -c "bash <(wget -qO- https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -install yes -panel 0 -ONLY_CF_IP_ALLOW no"
```
> 
> Recommended -ONLY_CF_IP_ALLOW yes + (Cloudflare<img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/cdnon.png" width="34">TURN ON) + SSL/TLS > Full
>
> Cloudflare > yourDomain > Network > gRPC <img src="https://raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/media/TURNON.png" height="16" width="32">
>
> SSL Support (yourdomain.com, *.yourdomain.com) for new subdomain, just add a new record A,AAAA[IP] in domain dns management! no need to reinstall the
panel!
> 
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

