# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

########################
#     COMANDI VARI     #
########################

###INDICE####
# Per trovare proprio IP
# per torvare proprio utente
# per trovare il proprio hostname
# per trovare timestamp in secondi dal 1 gennaio 1970
# Per trovare il carico della macchina con SNMP
# Modificare tabelle di routing
# firewall: VARIE
# schedulo esecuzione tra un ora (vedi esame 22/02/2007)
# usare tar su ssh in pipe (vedi esame 22/02/2007)
# limitare l'esecuzione di uno script ad uno
# snmpd.conf /// controllare l'esecuzione di uno script su un server
# filtro ldap con 3 elementi in AND
# seleziona il pid di un rocesso con una connessione ssh attiva
# eseguo modifica ad una entry LDAP
# terminazione dei processi di un utente
# estrarre il numero di byte passati da una catena iptables
# azzerare il numero di file passati da una catena
# controllare su quale dispositivo ci si trova in funzione dell'IP
# loggare nel file /var/log/pings ogni ping
# trovare il proprio defoult gateway address (potrebbe essere anche il campo 3)
# Per fare eseguire all'inizio del boot e responare uno scipt
# Setta il defoult GATEWAY
# estrarre l'ip del client che sta pingando il server
# abilitare l'esecuzione di 'sudo ss' in snmp extend
# esempio di file schema.LDIF
# aggiungere una direttiva di logging a rsyslog
# aggiornare una entry ldap
# controllare se un processo è in esecuzione con SNMP
# controlla in bg l'arrivo di pacchetti
# monitorare se è in esecuzione o meno un processo con SNMP
# monitorare il carico di un sistema con SNMP
# avviare script e demoni al boot
# osserva senza interruzione un file di log e quando ne riceve qualcuno fa qualcosa
# mappare un elemento della tabella extend si SNMP su un OID specifico
# ottengo un valore random



# Per trovare proprio IP
MYIP=$(ifconfig eth0 | grep "inet addr:" | cut -d: -f2 | cut -d' ' -f1) #con ifconfig
MYIP=$(ip addr show dev eth0 | grep "inet" | awk -F'inet ' '{print $2}' | cut -d'/' -f1) #con ip

# per torvare proprio utente
MYNAME=$(whoami)

# per trovare il proprio hostname
MYHOSTNAME=`cat /etc/hostname`

# per trovare timestamp in secondi dal 1 gennaio 1970
TIMESTAMP=$(date +"%s")

# Per trovare il carico della macchina con SNMP (il field da prendere è il 3 o il 4)
CARICO=$(snmpwalk -v 1 -c public 172.20.2.252  .1.3.6.1.4.1.2021.10.1.5.3 | cut -d' ' -f4)

# Modificare tabelle di routing
ip route del $MYIP/24 via $ROUTER #elimino
ip route add $MYIP/24 via $ROUTER #aggiungo

# firewall: accetta tutti i pacchetti dell'interfaccia di loopback
iptables -I INPUT -i lo -s 127.0.0.0/8 -j ACCEPT
iptables -I OUTPUT -o lo -d 127.0.0.0/8 -j ACCEPT
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
# firewall: abilito i pacchetti icmp
iptables -I INPUT -p icmp -i eth0 -j ACCEPT
iptables -I OUTPUT -p icmp -o eth0 --state ESTABLISHED -j ACCEPT
# firewall: inserisco nel packet filter le regole per LOGGARE i pacchetti di ICMP di ping
iptables -I INPUT -i eth0 -p icmp -j LOG --log-level warn --log-prefix "ping"
# firewall: accetta traffico SNMP
iptables -I INPUT -p udp --dport 161 -i eth0 -j ACCEPT
iptables -I OUTPUT -p udp --sport 161 -o eth0  --state ESTABLISHED -j ACCEPT
# firewall: accetta traffico RSYSLOG
iptables -I INPUT --dport 514 -i eth0 -j ACCEPT
iptables -I OUTPUT --sport 514 -o eth0  --state ESTABLISHED -j ACCEPT
# firewall: impostare il NAT tra un client ed un server su di un router per la porta 22		
iptables -t nat -I PREROUTING -p tcp -dport 22 -s $CLIENT -j DNAT --to-dest $SERVER_FIN
# firewall: imposta entry per un intero gruppo di macchine con IP contigui
for ((CONT=0; CONT <= 256 ; CONT++))
do
	# loggare i pacchetti iniziali delle connessioni SSH provenienti dai client e dirette all'indirizzo 10.1.1.254 
	# (prevedere una direttiva nella configurazione di rsyslog)
	iptables -I INPUT -s 10.1.1.$CONT -d 10.1.1.254 --tcp-flags SYN --dport 22 -j LOG --log-level warn --log-prefix "10.1.1.$CONT"
done

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
# 	extend /bin/ps haux | awk -F' ' '{print $11}'| grep "^client.sh" | wc -l

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

#controllare su quale dispositivo ci si trova in funzione dell'IP
if [ $(echo $MYIP | cut -d. -f4) -eq 202 ]
then
    ROUTER=fast
	configureIpTables()
elif [ $(echo $MYIP | cut -d. -f4) -eq 203 ]
then
    ROUTER=cheap
else
    echo Errore, non è possibile indicare il router su cui ci si trova
    exit 1
fi

# loggare nel file /var/log/pings ogni ping
# 	egrep -v 'kern.warn' /etc/rsyslog.conf > /tmp/rsyslog.conf 
# 	echo -e "kern.warn\t\t/var/log/pings" >> /tmp/rsyslog.conf
# 	cat /tmp/rsyslog.conf > /etc/rsyslog.conf
# 	/etc/init.d/rsyslog restart

# trovare il proprio defoult gateway address (potrebbe essere anche il campo 3)
ip r | grep default | cut -d' ' -f4

# Per fare eseguire all'inizio del boot e responare uno scipt
# 	devo andare a modificare il file 
# 	/etc/inittab e inserire una riga in cui specifico che questo bash deve essere
# 	eseguito al boot, con la seguente sintassi
# 	xx:345:respawn:/usr/bin/script_mio.sh

# Setta il defoult GATEWAY
ip route add default via 192.168.1.1

#estrarre l'ip del client che sta pingando il server
sudo tcpdump -vnlp -c 1 --immediate-mode -i any icmp 2>/dev/null | grep "ICMP echo request" | cut -d">" -f1 

# abilitare l'esecuzione di 'sudo ss' in snmp extend
# snmp    ALL = NOPASSWD:/bin/ss
# con la configurazione:  extend    command		/usr/bin/sudo /bin/ss -ntp

# esempio di file schema.LDIF
dn: cn=users,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: users
olcAttributeTypes: ( 1000.1.1.20 NAME ( 'utente' )
  DESC 'nome utente'
  EQUALITY caseExactMatch
  SUBSTR caseExactSubstringsMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: ( 1000.1.1.21 NAME ( 'server' )
  DESC 'ip server'
  EQUALITY caseExactMatch
  SUBSTR caseExactSubstringsMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: ( 1000.1.1.22 NAME ( 'traffic' )
  DESC 'traffico nel formato ts_traffico'
  EQUALITY caseExactMatch
  SUBSTR caseExactSubstringsMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcObjectClasses: ( 1000.2.1.4 NAME 'users'
  DESC 'utente'
  MUST ( utente )
  STRUCTURAL )
olcObjectClasses: ( 1000.2.1.5 NAME 'access'
  DESC 'accesso'
  MUST ( server )
  MAY ( traffic )
  STRUCTURAL )

#  aggiungere una direttiva di logging a rsyslog
egrep -v 'local*.info' /etc/rsyslog.conf > /tmp/rsyslog.conf
echo "local*.info    @$SERVER" >> /tmp/rsyslog.conf
cat /tmp/rsyslog.conf > /etc/rsyslog.conf
systemctl restart rsyslogd

# aggiornare una entry ldap
if test ldapsearch -LLL -h $SERVER -x -s sub -b "dc=labammsist" (& (&("objectClass=cliserv")("server=$SERVER")) ("client=$CLIENT")) #controllo se è presente
	then 
		ldapsearch -LLL -h $SERVER -x -s base -b "dc=labammsist" (& (&("objectClass=cliserv")("server=$SERVER")) ("client=$CLIENT")) | (while read riga #preleva tutte le entry
		do
			ATT=`echo $riga | cut -d: -f1`
			if test $ATT = "timestamp" #controlla se è quella da modificare
				then echo "changetype: modify"
        			echo "replace: timestamp"
        			echo "timestamp: `date +"%s"`"
			else echo $riga #se non lo è la passa alla pipe
		done) | ldapmodify -x -h $SERVER -D "cn=admin,dc=labammsist" -w admin #modifica le entry o le lascia invariate se non sono da modificare
	else 
		echo "dn: server=$SERVER,dc=labammsist" >> /tmp/ldif.$$ #inserisce una nuova entry se non presente
		echo "objectClass: cliserv" >> /tmp/ldif.$$
		echo "server: $SERVER" >> /tmp/ldif.$$
		echo "client: $CLIENT" >> /tmp/ldif.$$
		echo "timestamp: `date +"%s"`" >> /tmp/ldif.$$
		echo >> /tmp/ldif.$$
	
		ldapadd -x -h $SERVER -D "cn=admin,dc=labammsist" -w admin -f /tmp/ldif.$$
		rm -f /tmp/ldif.$$
fi

#controllare se un processo è in esecuzione con SNMP
#aggiungere "proc rsyslogd" al file snmpd.conf
OID=`snmpwalk -v 1 -c public $SERVER .1.3.6.1.4.1.2021.2.2 | grep "rsyslogd" | cut -d. -f11` #prelevo gli OID del processo in scansione
FLAG=`snmpwalk -v 1 -c public $SERVER .1.3.6.1.4.1.2021.2.100.$OID | awk -F'=' '{ print $2}'` #vedo se ci sono errorei associati (cut -d\" -f2)

# controlla in bg l'arrivo di pacchetti e li logga
tcpdump -vnlp tcp | egrep -v "IP" >> /tmp/file_log &

tcpdump -vnlp tcp | grep ">" | ( while read riga
do

# monitorare se è in esecuzione o meno un processo con SNMP
# proc <nomeProcesso>
proc sshd

# monitorare il carico di un sistema con SNMP
load 0.5

# avviare script e server al boot
# init legge il suo file di configurazione in maniera lineare, e fa partire i diversi processi
# nell'ordine in cui li legge da /etc/inittab
# xx::boot:/etc/init.d/sshd
# xx::boot:/usr/bin/server-up.sh

# osserva senza interruzione un file di log e quando ne riceve qualcuno fa qualcosa
tail -f /var/log/connections | ( while read riga
do
	<ROBA_DA_FARE>
done )

# mappare un elemento della tabella extend si SNMP su un OID specifico
extend .1.3.6.1.4.1.2021.60 esame1 /bin/ps h -o user -C richiedi.sh

# ottengo un valore random
RANDOM=$[ `rand --max 8` + 1]

# esegue richiesta ssh in background
ssh -f @10.9.9.1 ./recupera.sh $1
