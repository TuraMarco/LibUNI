# Per trovare proprio IP
MYIP=`ifconfig eth0 | grep "inet addr:" | cut -d: -f2 | cut -d' ' -f1`

# Per trovare il carico della macchina con SNMP (il field da prendere è il 3 o il 4)
CARICO=`snmpwalk -v 1 -c public 172.20.2.252  .1.3.6.1.4.1.2021.10.1.5.3 | cut -d' ' -f4`

# Modificare tabelle di routing
ip route del $MYIP/24 via $ROUTER #elimino
ip route add $MYIP/24 via $ROUTER #aggiungo

# firewall: accetta connessioni LDAP dai client...
iptables -I INPUT -p tcp --dport 389 -s <IP_CLIENT> -j ACCEPT
iptables -I OUTPUT -p tcp --sport 389 -d <IP_CLIENT> -j ACCEPT
# firewall: inoltra il traffico ssh tra client e server ...
iptables -I FORWARD -p tcp --dport 22 -s <IP_CLIENT> -d <IP_SERVER> -j ACCEPT
iptables -I FORWARD -p tcp --sport 22 -d <IP_CLIENT> -s <IP_SERVER> ! --syn -j ACCEPT
# firewall: consente tutto il traffico locale
iptables -I INPUT -i lo -j ACCEPT
iptables -I OUTPUT -o lo -j ACCEPT
# firewall: blocca tutto di default
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# schedulo esecuzione tra un ora
.... | at now + 1 hour