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
    bootorder=$(sshpass -p $PASS ssh $SSHOPTS $USER@$1.$i \
        racadm get BIOS.BiosBootSettings.bootseq | grep BootSeq=)
    echo "$1.$i : $bootorder"
  done
}


echo "##### row 01 rack 01 : U36 --> U1 #####" 
racadm_cmd 10.1.2 130 165  

echo "##### row 01 rack 02 : U36 --> U1 #####" 
racadm_cmd 10.1.1 66 101  

echo "##### row 01 rack 03 : U36 --> U1 #####"
racadm_cmd 10.1.0 130 165  

echo "##### row 01 rack 04 : U36 --> U1 #####"
racadm_cmd 10.1.2 2 37  

echo "##### row 01 rack 06 : U36 --> U1 #####" 
racadm_cmd 10.1.0 66 101  

echo "##### row 01 rack 07 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.4 2 20  

echo "##### row 01 rack 08 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.2 194 212  

echo "##### row 01 rack 09 : U37, U35 --> U1 #####"
racadm_cmd 10.1.3 66 84  

echo "##### row 01 rack 10 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.3 2 20  

##

echo "##### row 02 rack 01 : U36 --> U1 #####" 
racadm_cmd 10.1.2 66 101  

echo "##### row 02 rack 02 : U36 --> U1 #####" 
racadm_cmd 10.1.0 2 37  

echo "##### row 02 rack 03 : U36 --> U1 #####" 
racadm_cmd 10.1.1 130 165  

echo "##### row 02 rack 04 : U36 --> U1 #####" 
racadm_cmd 10.1.1 194 229  

echo "##### row 02 rack 06 : U36 --> U1 #####" 
racadm_cmd 10.1.0 194 229  

echo "##### row 02 rack 07 : U36 --> U1 #####" 
racadm_cmd 10.1.1 2 37  

echo "##### row 02 rack 08 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.4 66 84  

echo "##### row 02 rack 09 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.3 194 212  

echo "##### row 02 rack 10 : U37, U35 --> U1 #####" 
racadm_cmd 10.1.3 130 148  
