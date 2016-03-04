#/bin/bash 

# Check Dell server boot orders through iDRAC

USER=root
PASS=calvin
SSHOPTS="-q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

function racadm_cmd () 
{
  # $1 row; $2 rack; $3 type; $4 start; $5 stop
  for i in `seq $4 $5`
  do
    bootorder=$(sshpass -p $PASS ssh $SSHOPTS $USER@cnlvr${1}r${2}${3}${i}-oob.lv.cncf.io \
        racadm get BIOS.BiosBootSettings.bootseq | grep BootSeq=)
    echo "cnlvr${1}r${2}${3}${i}-oob : $bootorder"
  done
}


echo "##### row 01 rack 01 #####" 
racadm_cmd 01 01 c 1 36

echo "##### row 01 rack 02 #####" 
racadm_cmd 01 02 c 1 36

echo "##### row 01 rack 03 #####"
racadm_cmd 01 03 c 1 36

echo "##### row 01 rack 04 #####"
racadm_cmd 01 04 c 1 36

echo "##### row 01 rack 06 #####" 
racadm_cmd 01 06 c 1 36

echo "##### row 01 rack 07 #####" 
racadm_cmd 01 07 s 1 19

echo "##### row 01 rack 08 #####" 
racadm_cmd 01 08 s 1 19

echo "##### row 01 rack 09 #####"
racadm_cmd 01 09 s 1 19

echo "##### row 01 rack 10 #####" 
racadm_cmd 01 10 s 1 19

##

echo "##### row 02 rack 01 #####" 
racadm_cmd 02 01 c 1 36

echo "##### row 02 rack 02 #####" 
racadm_cmd 02 02 c 1 36

echo "##### row 02 rack 03 #####" 
racadm_cmd 02 03 c 1 36

echo "##### row 02 rack 04 #####" 
racadm_cmd 02 04 c 1 36

echo "##### row 02 rack 06 #####" 
racadm_cmd 02 06 c 1 36

echo "##### row 02 rack 07 #####" 
racadm_cmd 02 07 s 1 19

echo "##### row 02 rack 08 #####" 
racadm_cmd 02 08 s 1 19

echo "##### row 02 rack 09 ####"
racadm_cmd 02 09 s 1 19

echo "##### row 02 rack 10 ####"
racadm_cmd 02 10 s 1 19"
