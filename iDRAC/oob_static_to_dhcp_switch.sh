#!/bin/bash 

USER=root
PASS=calvin
SSHOPTS="-q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

function pause() {
    read -p "Press [ENTER] to continue..."
}


function racadm_cmd ()
{
  # $1 net; $2 start_ip; $3 stop_ip
  for i in `seq $2 $3`
  do
    echo "IP: $1.$i"
    sshpass -p $PASS ssh $SSHOPTS $USER@$1.$i racadm set iDRAC.IPv4.DHCPEnable Enabled
  done
}


#echo "#### release existing hosts with STATIC IP's on 10.1.4.0/24 #####"
#racadm_cmd 10.1.4 1 255

#racadm_cmd 10.1.0 35 35
#racadm_cmd 10.1.0 224 224
#racadm_cmd 10.1.1 85 85
#racadm_cmd 10.1.1 94 94
#racadm_cmd 10.1.1 130 130
#racadm_cmd 10.1.2 66 66 
racadm_cmd 10.1.2 91 91
#racadm_cmd 10.1.3 204 204



