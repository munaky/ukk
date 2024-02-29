/interface wireless
set [ find default-name=wlan1 ] disabled=no mode=ap-bridge ssid=UKK_NAJIB
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
add dns-name=login-hotspot.gov hotspot-address=192.168.100.1 login-by=http-chap name=\
    hsprof1
/ip hotspot user profile
add address-list="ip guest" name=Guest rate-limit=2m shared-users=unlimited
add name=Staff rate-limit=5m shared-users=unlimited
/ip pool
add name=dhcp_pool0 ranges=172.16.0.2-172.16.0.254
add name=hs-pool-1 ranges=192.168.100.2-192.168.100.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 name=dhcp1
add address-pool=hs-pool-1 disabled=no interface=wlan1 lease-time=1h name=\
    dhcp2
/ip hotspot
add address-pool=hs-pool-1 disabled=no interface=wlan1 name=hotspot1 profile=\
    hsprof1
/ip address
add address=172.16.0.1/24 interface=ether2 network=172.16.0.0
add address=192.168.100.1/24 interface=wlan1 network=192.168.100.0
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=172.16.0.0/24 gateway=172.16.0.1
add address=192.168.100.0/24 gateway=192.168.100.1
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward dst-address=!192.168.250.236 src-address-list=\
    "ip guest"
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface=ether1
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.100.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.100.0/24
/ip hotspot user
add name=guest password=4321 profile=Guest
add name=staff password=1234 profile=Staff
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=UKK_NAJIB
