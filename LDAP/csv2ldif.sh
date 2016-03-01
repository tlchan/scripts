#!/bin/bash 

# Extract user data from CSV and convert into ldif 

IFS=","

i=0

# usertype uidnum firstname lastname username email password company
while read usertype uidnum firstname lastname username email password company
do 
  hashedpw=`slappasswd -s $password`
  dn[$i]="uid=$username,ou=$usertype,ou=lv,dc=cncf,dc=io"
  echo "dn: ${dn[$i]}"
  echo "changetype: add"
  echo "objectClass: posixAccount"
  echo "objectClass: top"
  echo "objectClass: inetOrgPerson"
  echo "gidNumber: 1000"
  echo "givenName: $firstname"
  echo "sn: $lastname"
  echo "displayName: $firstname $lastname"
  echo "uid: $username"
  echo "homeDirectory: /home/$username"
  echo "loginShell: /bin/bash"
  echo "cn: $firstname $lastname"
  echo "uidNumber: $uidnum"
  echo "userPassword: $hashedpw"
  echo "mail: $email"
  echo "o: $company"
  echo ""
  ((i++))
done < $1

echo "dn: cn=vpnaccess,ou=groups,ou=lv,dc=cncf,dc=io"
echo "changetype: modify"
echo "add: uniquemember"
for (( i=0; i<${#dn[@]}; i++ ));
do
  echo "uniqueMember: ${dn[$i]}"
done



