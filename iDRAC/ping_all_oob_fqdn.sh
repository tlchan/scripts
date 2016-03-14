#/bin/bash 

# ping and optionally check iDRAC connectivity to all OOB hosts by FQDN

USER=root
PASS=calvin
SSHOPTS="-q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=5 -o ConnectionAttempts=1"

IDRAC_CHECK=1

function racadm_cmd ()
{
  # $1 row; $2 rack; $3 type; $4 start; $5 stop
  for i in `seq $4 $5`
  do
    FQDNOOB="cnlvr${1}r${2}${3}${i}-oob.lv.cncf.io"
    IPADDROOB=`ping -q -n -t 1 -c 1 $FQDNOOB | grep "(" | cut -d ' ' -f 3`
    ping -q -n -t 5 -c 1 $FQDNOOB > /dev/null
    STATUS=$?
    SERVICETAG="......."
    if [ "$STATUS" -eq "0" -a "$IDRAC_CHECK" -eq "1" ]; then
      SERVICETAG=$(sshpass -p calvin ssh $SSHOPTS $USER@$FQDNOOB racadm getsysinfo | grep "Service Tag" | cut -d '=' -f 2 )
    fi
    echo "[$FQDNOOB --> $IPADDROOB = $STATUS = $SERVICETAG]"
  done
}


for i in 01 02 03 04 06; do
echo "##### row 01 rack $i #####"
racadm_cmd 01 $i c 1 36
done

for i in 07 08 09 10; do
echo "##### row 01 rack $i #####"
racadm_cmd 01 $i s 1 19
done

for i in 01 02 03 04 06 07; do
echo "##### row 02 rack $i #####"
racadm_cmd 02 $i c 1 36
done

for i in 08 09 10; do
echo "##### row 02 rack $i #####"
racadm_cmd 02 $i s 1 19
done
