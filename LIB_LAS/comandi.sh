# Per trovare proprio IP
MYIP=$(ifconfig eth0 | grep "inet addr:" | cut -d: -f2 | cut -d' ' -f1) #con ifconfig
MYIP=$(ip addr show dev eth0 | grep "inet" | awk -F'inet ' '{print $2}' | cut -d'/' -f1) #con ip

# per torvare proprio utente
UTENTE=$(whoami)

# per trovare timestamp in secondi dal 1 gennaio 1970
TIMESTAMP=$(date +"%s")

# Per trovare il carico della macchina con SNMP (il field da prendere è il 3 o il 4)
CARICO=$(snmpwalk -v 1 -c public 172.20.2.252  .1.3.6.1.4.1.2021.10.1.5.3 | cut -d' ' -f4)

# Modificare tabelle di routing
ip route del $MYIP/24 via $ROUTER #elimino
ip route add $MYIP/24 via $ROUTER #aggiungo

# firewall: accetto il traffico ssh
iptables -I INPUT -p tcp --dport 22 -s $IP -d $MYIP -j ACCEPT
iptables -I OUTPUT -p tcp --sport 22 -d $IP -s $MYIP -m state --state ESTABLISHED -j ACCEPT
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

# schedulo esecuzione tra un ora (vedi esame 22/02/2007)
.... | at now + 1 hour

# usare tar su ssh in pipe (vedi esame 22/02/2007)
tar -cf - myFile.txt | ssh $IP_SERVER ./ScriptServer.sh     #ScriptClient.sh
tar -xf - -C ~/backups/                                     #ScriptServer.sh

# limitare l'esecuzione di uno script ad uno
N_INSTANCE=$(ps haux | awk -F' ' '{print $11}'| grep "^client.sh" | wc -l)
if test $N_INSTANCE -gt 1
	then exit 1
fi

# snmpd.conf /// controllare l'esecuzione di uno script su un server
extend /bin/ps h haux | awk -F' ' '{print $11}'| grep "^client.sh" | wc -l

#filtro ldap con 3 elementi in AND
( & ( &("objectClass=richiesta")("utente=$2")) ("ip=$1"))

# seleziona il pid di un rocesso con una connessione ssh attiva (forse non è il campo 7 ma l'8)
PID=`netstat -p -t | grep "/etc/ini.d/ssh" | grep "$IP" | awk -F' ' '{print $7}' | cut -d// -f1`

# eseguo modifica ad una entry LDAP
(
	echo `ldapsearch -LLL -h 10.1.1.254 -x -s base -b "dc=labammsist" "objectClass=$UTENTE" | grep "^dn" `
	echo "changetype: modify"
	echo "replace: Stato"
	echo "Stato: connesso"
	echo "changetype: modify"
	echo "replace: IP"
	echo "IP: $IP"
) | ldapmodify -x -h 10.1.1.254 -D "cn=admin,dc=labammsist" -w admin

# terminazione dei processi di un utente
UTENTE=`whoami`
ps haux | grep "^$UTENTE" | awk -F' ' '{print $2}' | ( while read RIGA
do
	kill -9 $RIGA
done )

# estrarre il numero di byte passati da una catena iptables
BYTES=`iptables -vnxL INPUT | head -1 | cut -d' ' -f7`

# azzerare il numero di file passati da una catena
iptables -Z CUSTOM_$IP
