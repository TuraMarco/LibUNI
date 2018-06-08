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
#   all'internpo del file ~/.bashrc, in alternativa è possibile esportare ed importare le regole su e da un file con i seguenti comandi:
#   Salva la configurazione corrente sul file
iptables-save > rules.txt
#   Ripristina la configurazione salvata
iptables-restore < rules.txt

# RIMUOVERE UNA REGOLE -------------------------------------------------------------------------------------------------------------------
# Al fine di rimuovere una regole si possono usare 2 strade: usare il flag -D per poi specificare il numero della regola, 
#   oppure riportando l'intera regola per intero.
#   Alcuni esempi possono essere:
iptables -D INPUT 2                     # Elimina la regola numero 2 dalla catena di INPUT
iptables -D INPUT -s 10.1.1.1 -j ACCEPT # Elimina la regola che ha la firma indicata
iptables -F INPUT                       # Elimina tutte le regole della chain indicata

# TABELLE NAT ----------------------------------------------------------------------------------------------------------------------------
# La tabella NAT permette di effettuare delle modifiche ai pacchetti in modo che risultino traslate a livello di
#   indirizzo. 
#   Lavora sui pacchetti forwarded, questo implica che per utilizzare il NAT `e necessario abilitare le
#   regole di FORWARD esposte in precedenza con il comando:
iptables -P FORWARD ACCEPT
# Una volta fatto cio è possibile impostare il router in 2 comportamenti distinti:
#   |- DESTINATION NAT ---> permette di intercettare le connessioni da Client a Router, ridirigendole automaticamente al Server. 
#   |_ SOURCE NAT --------> Permette di mascherare la sorgente di un pacchetto, in modo da offuscare il mittente originale
# Per quanto riguarda il Destination_Nat il Router impersona Server ed il Client non si accorge di nulla, quindi il router dovrà essere 
#   impostato con una regola iptables che intercetti la connessione SSH da client a router e la ridiriga al server.
iptables -t nat -A PREROUTING -i eth2 -s 10.1.1.1 -d 10.1.1.254 -p tcp --dport 22 -j DNAT --to-dest 10.9.9.1

                            #SRCE 10.1.1.1                          #SRCE 10.1.1.1
        #################   #DEST 10.1.1.254    #################   #DEST 10.9.9.1      #################            
        #               #-------------------->>>#  10.1.1.254   #-------------------->>>#               #
        #    CLIENT     #                       #    ROUTER     #                       #    SERVER     #
        #   10.1.1.1    #<<<--------------------#  10.9.9.254   #<<<--------------------#   10.9.9.1    #
        #################   #SRCE 10.1.1.254    #################   #SRCE 10.9.9.1      #################
                            #DEST 10.1.1.1                          #DEST 10.1.1.1

# Il Source_Nat si ha In pratica, quanto il Client invia un pacchetto al Server, questo lo riceve come se lo avesse
#   mandato il Router, quando poi il Server invierà la risposta al Router, questo si occuperà di inoltrarla al Client.
iptables -t nat -A PREROUTING -o eth1 -s 10.1.1.1 -d 10.9.9.1 -j SNAT --to-source 10.9.9.254

                            #SRCE 10.1.1.1                          #SRCE 10.9.9.254
        #################   #DEST 10.9.9.1      #################   #DEST 10.9.9.1      #################            
        #               #-------------------->>>#  10.1.1.254   #-------------------->>>#               #
        #    CLIENT     #                       #    ROUTER     #                       #    SERVER     #
        #   10.1.1.1    #<<<--------------------#  10.9.9.254   #<<<--------------------#   10.9.9.1    #
        #################   #SRCE 10.9.9.1      #################   #SRCE 10.9.9.1      #################
                            #DEST 10.1.1.1                          #DEST 10.1.1.254

# CHAIN PERSONALIZZATE -------------------------------------------------------------------------------------------------------------------
# Iptables permette di creare chain personalizzate in modo da semplificare la gestione di pacchetti anche in modo molto articolato, 
#   in breve i comandi fondamentali sono:
#   1) Creare la chain personalizzata dandole un nome significativo (MYCHAIN in questo caso).
iptables -N MYCHAIN
#   2) Inserire una regola all'interno della chian personalizzata che facia il return alla chain chiamante.
iptables -I MYCHAIN -j RETURN 
#   3) Fare il flush delle regole della chain personalizzata.
iptables -F MYCHAIN
#   4) Eliminare la chain personalizzata.
iptables -X MYCHAIN


# FUNZIONI UTILI -------------------------------------------------------------------------------------------------------------------------
#Spesso è comodo definire una funzione per aggiungere un set di regole a iptables parametrizzando il
#   tipo di operazione, questo permette di aggiungere e rimuovere queste regole con facilità.
#   ARG: $1 A oppure D per aggiungere o togliere la regola.
function gestisciRegola () 
{
    iptables -$1 <opzione> -j <esito>
}
# Esempio d’uso
gestisciRegola A # Aggiungo la regola in fondo
gestisciRegole I # Aggiungo la regola in testa
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
#   Le seguenti regole ad esempio permettono di loggare l'inizio di una connessione con livello debug e prefisso NEW_CONNECTION:
iptables -I FORWARD -i eth2 -s 10.1.1.1 -d 10.9.9.1 -p tcp --tcp-flags SYN SYN -j LOG --log-prefix "NEW_CONNECTION" --log-level debug
#   e la fine loggando sepre in debug ma con prefisso END_CONNECTIN:
iptables -I FORWARD -i eth2 -s 10.1.1.1 -d 10.9.9.1 -p tcp --tcp-flags FIN FIN -j LOG --log-prefix "END_CONNECTIN" --log-level debug