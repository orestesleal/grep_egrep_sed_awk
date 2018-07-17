#n
/^[a-z]\{1,\}[0-9]\{1,\}:/,/hwaddr/{
/^lo[0-9]:/,/: lo.*/d 
/^tun[0-9]:/,/: tun.*/d
/hwaddr/d
s/flags.*mtu/\
        mtu:/
s/^.*options.*$//
s/^.*ether /	MAC: /
/^$/d
p
}
