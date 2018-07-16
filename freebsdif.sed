#n
/^[a-z]\{1,\}[0-9]\{1,\}:/,/hwaddr/{

        # remove the loopback entry
        /^lo[0-9]:/,/: lo.*/d 

        # remove tun interfaces
        /^tun[0-9]:/,/: tun.*/d

        # remove the hardware address line
        /hwaddr/d

        # remove everything until the MTU, add a new line
        s/flags.*mtu/\
	mtu:/
  
        s/^.*options.*$//
        s/^.*ether /	MAC: /
        /^$/d
        p
}
