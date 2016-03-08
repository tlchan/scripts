#/bin/bash 

# Check Dell server boot orders through iDRAC

USER=root
PASS=calvin
SSHOPTS="-q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=10"

function racadm_cmd () 
{
  # $1 row; $2 rack; $3 type; $4 start; $5 stop
  for i in `seq $4 $5`
  do
    FQDN="cnlvr${1}r${2}${3}${i}-oob.lv.cncf.io"
    IPADDR=`ping -c1 $FQDN | grep from | cut -d ' ' -f 4`
    bootorder=$(sshpass -p $PASS ssh $SSHOPTS $USER@$FQDN \
        racadm get BIOS.BiosBootSettings.bootseq | grep BootSeq=)
    echo "[$FQDN --> $IPADDR ] $bootorder"
  done
}


for i in 01 02 03 04 05 06; do
  echo "##### row 01 rack $i #####" 
  racadm_cmd 01 $i c 1 36
done 

for i in 07 08 09 10; do
  echo "##### row 01 rack $i #####" 
  racadm_cmd 01 $i s 1 19
done 

for i in 01 02 03 04 05 06 07; do
  echo "##### row 02 rack $i #####"
  racadm_cmd 02 $i c 1 36
done

for i in 08 09 10; do
  echo "##### row 02 rack $i #####"
  racadm_cmd 02 $i s 1 19
done
