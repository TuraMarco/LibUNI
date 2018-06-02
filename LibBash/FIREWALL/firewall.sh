# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

#########################
#  FIREWALL & IPTABLES  #
#########################

# IPTABLES -------------------------------------------------------------------------------------------------------------------------------
# Il defoult stateful packet filter di linux è iptables, un sottosistema del kernel adibito al controllo 
#   dei pacchetti in ingresso, uscita e transito sulle interfaccia di rete.
#   I pacchetti sono sottoposti a diverse modalità di elaborazione chiamate table, ciascuna delle quali è composta 
#   a sua volta da gruppi di regole chiamate chain (vedi ./nfk-traversal.png).
#   Tra le varie tabelle quella di FILTER implementa le regole di firewall vere e proprie, ed al suo interno sono contenute 
#   3 chain predefinite:
#       |- INPUT -----> Contiene le regole di filtraggio da applicare ai pacchetti in ingresso.
#       |- OUTPUT ----> Contiene le regole di filtraggio da applicare ai pacchetti in uscita.
#       |_ FORWARD ---> Contiene le regole di filtraggio da applicare ai pacchetti in transito (inoltrati su interfacce diverse).

# VISUALIZARE REGOLE ---------------------------------------------------------------------------------------------------------------------
# Il comando per visualizzare le regole configurate nella iptables è:
sudo iptables -vnxL --line-numbers
#   I fleg usati hanno il segunte significato:
#       |- -v ---> Output verboso.
#       |- -n ---> Nega la conversione degli IP (numerici) in HostName.
#       |- -x ---> Visualizza l'esatto valore di byte evitando formati più human readable.
#       |_ -L ---> Lista le regole della IpTables
#   E' importante ricordare che ogni chiamata alla iptables deve essere fatta come utente root o come utente privilegiato.

# POLICY DI DEFOULT ---------------------------------------------------------------------------------------------------------------------
# Un utente root o privilegiato può personalizzare il comportamento del firewall aggiungendo regole alle catene con la finalità 
#   che ogni pacchetto amministrato da iptables raggiunga uno dei possibili esiti:
#       |- DROP -----> Scarta il pacchetto.
#       |- REJECT ---> Scarta il pacchetto notificandolo al mittente con un pacchetto ICMP.
#       |_ ACCEPT ---> Accetta il pacchetto.
#   ogni catena è una serie di regole che vengono analizzate in successione, sino a quando un pacchetto non meccia con una di esse,
#   nel caso nessuna di esse fosse accettata il pacchetto in esame viene gestito con la policy di DEFOULT, che è possibile 
#   specificare con il seguente comando
#
#   iptables -P <chain_name> <esito>
#
#   Ad esempio nel caso si vogliano scartare tutti i pacchetti che non mecciano con una delle regole:
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# AGGIUNGERE NUOVE REGOLE ----------------------------------------------------------------------------------------------------------------
# Per aggiungere una nuova regola alle catene si usa il seguente comando:
iptables -A FORWARD <options> -j ACCEPT
#   oppure
iptables -I FORWARD <options> -j ACCEPT
#   in questi due casi il risultato è simile con la differenza che la regola viene inserita in coda (flag -A) oppure in testa (flag -I).
#   E' possibile specificare opzioni di filtraggio estremamente precise e granulari, anche se le piu importanti sono:
#       |- -i eth3 ------------> Solo pacchetti in ingresso dall'interfaccia eth3.
#       |- -o eth3 ------------> Solo pacchetti in uscita dall'interfaccia eth3.
#       |- -s <IP> ------------> Solo pacchetti provenienti dall'IP specifico.
#       |- -d <IP> ------------> Solo pacchetti destinati all'IP specifico.
#       |- -p <PROTOCOLLO> ----> Solo pacchetti del PROTOCOLLO specifico.
#                                   |- --dport <prt> --------------> Nel caso di protocollo UPD o TCP specifico la porta di destinazione.
#                                   |- --sport <prt> --------------> Nel caso di protocollo UPD o TCP specifico la porta sorgente.
#                                   |_ -m state --state <stato> ---> Nel caso di protocollo TCP lo stato della connessione
#                                                                       |- NEW ------------> Nuova connessione.
#                                                                       |- ESTABLISHED ----> Connessione stabilita
#                                                                       |_ RELATED --------> Connessione già esistente
#   E' importante ricordarsi che le regole iptables non sono persistenti e se si vuole renderle tali è necessario scriverle 
#   all'internpo del file ~/.bashrc

# RIMUOVERE UNA REGOLE -------------------------------------------------------------------------------------------------------------------
# Al fine di rimuovere una regole si possono usare 2 strade: usare il flag -D per poi specificare il numero della regola, 
#   oppure riportando l'intera regola per intero.
#   Alcuni esempi possono essere:
iptables -D INPUT 2                     # Elimina la regola numero 2 dalla catena di INPUT
iptables -D INPUT -s 10.1.1.1 -j ACCEPT # Elimina la regola che ha la firma indicata
iptables -F INPUT                       # Elimina tutte le regole della chain indicata

# FUNZIONI UTILI -------------------------------------------------------------------------------------------------------------------
#Spesso `e comodo definire una funzione per aggiungere un set di regole a iptables parametrizzando il
#   tipo di operazione, questo permette di aggiungere e rimuovere queste regole con facilità.
#   ARG: $1 A oppure D per aggiungere o togliere la regola.
function gestisciRegola () 
{
    iptables -$1 <opzione> -j <esito>
}
# Esempio d’uso
gestisciRegola A # Aggiungo la regola
gestisciRegola D # Elimino la regola

# Alcune regole sono fondamentali e vanno sempre specificate prima di introdurre delle nuove policy di default.
#   Accetta tutti i pacchetti dell'interfaccia di loopback
iptables -I INPUT -i lo -s 127.0.0.0/8 -j ACCEPT
iptables -I OUTPUT -o lo -d 127.0.0.0/8 -j ACCEPT
#   Consenti le connessioni SSH (in questo caso dall'HOST alle macchine)
iptables -I INPUT -i eth3 -s 192.168.56.1 -d 192.168.56.20x -p tcp -- dport 22 -j ACCEPT
iptables -I OUTPUT -o eth3 -d 192.168.56.1 -s 192.168.56.20x -p tcp -- sport 22 -m state -- state ESTABLISHED -j ACCEPT

# Al fine di raccogliere dati sul funzionamento della rete è possibile inserire regole iptables che come esito intermedio 
#   loggano i pacchetti, cio viene fatto inserendo una regola del tipo:
iptables -I <chain> <options> -j LOG --log-prefix="prefisso_log" --log-level <livello_log>
#   E' importante ricordare che i log essendo iptables una componente gestita dal kernel avranno una faciliy=kernel, 
#   quindi specificando un livello di log debug ad esempio avremo che i log verranno salvati in kernel.debug (vedi LOG).



