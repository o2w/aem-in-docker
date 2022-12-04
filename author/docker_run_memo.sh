# https://stackoverflow.com/a/24326540
# https://github.com/kylemanna/docker-openvpn/issues/670
# https://reasonable-code.com/docker-iptables/
# https://qiita.com/osamunmun/items/1786aac5904439522d72
# https://askubuntu.com/a/1168302
docker run --network="host" --privileged  --cap-add=NET_ADMIN -p 4502:4502 aem-author

