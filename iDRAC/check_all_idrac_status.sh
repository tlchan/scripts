#/bin/bash 

# Check Dell server boot orders through iDRAC

USER=root
PASS=calvin
SSHOPTS="-q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

function racadm_cmd () 
{
  # $1 net; $2 start_ip; $3 stop_ip
  for i in `seq $2 $3`
  do
    retstatus=$(sshpass -p $PASS ssh $SSHOPTS $USER@$1.$i \
        racadm getsysinfo | grep "Service Tag" | cut -d '=' -f 2)
    echo "$1.$i : $retstatus"
  done
}


echo "##### row 01 rack 01 : U36 --> U1 #####" 
racadm_cmd 10.1.0 2 2
echo ".3-.4 mangement hosts"
racadm_cmd 10.1.0 5 37

echo "##### row 01 rack 02 : U36 --> U1 #####" 
racadm_cmd 10.1.0 46 78
echo ".43-.45 management hosts"

echo "##### row 01 rack 03 : U36 --> U1 #####"
racadm_cmd 10.1.0 86 119
echo ".84-.85 management hosts"

echo "##### row 01 rack 04 : U36 --> U1 #####"
racadm_cmd 10.1.0 125 160

echo "##### row 01 rack 06 : U36 --> U1 #####" 
racadm_cmd 10.1.0 166 201

echo "##### row 01 rack 07 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.0 210 225
echo ".207-.209 ceph hosts"

echo "##### row 01 rack 08 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.0 231 248

echo "##### row 01 rack 09 : U37, U35 --> U1 #####"
racadm_cmd 10.1.0 255 255
racadm_cmd 10.1.1 1 18

echo "##### row 01 rack 10 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.1 24 42

##

echo "##### row 02 rack 01 : U36 --> U1 #####" 
racadm_cmd 10.1.1 48 83

echo "##### row 02 rack 02 : U36 --> U1 #####" 
racadm_cmd 10.1.1 89 124

echo "##### row 02 rack 03 : U36 --> U1 #####" 
racadm_cmd 10.1.1 130 165  

echo "##### row 02 rack 04 : U36 --> U1 #####" 
racadm_cmd 10.1.1 171 206

echo "##### row 02 rack 06 : U36 --> U1 #####" 
racadm_cmd 10.1.1 212 247

echo "##### row 02 rack 07 : U36 --> U1 #####" 
racadm_cmd 10.1.1 253 255
racadm_cmd 10.1.2 1 33

echo "##### row 02 rack 08 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.2 39 57

echo "##### row 02 rack 09 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.2 63 81

echo "##### row 02 rack 10 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.2 87 105
