# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

################
#     SNMP     #
################
# Il protocollo SNMP permette di gestire in maniera semplificata diverse risorse di rete. 
#   Ogni oggetto è rappresentato da un OID univoco ed incluso in un database detto MIB.

# PREDISPOSIZIONE --------------------------------------------------------------------------------------------
# Editare file /etc/snmp/snmp.conf e commentare la riga 
#
#       mibs :      >>>>>>>>>     #mibs :
#
#   in questo modo si visualizzano i soli nomi simbolici delle risorse e non  gli OID 
#   che sarebbero difficilmente identificabili.
#
# Nel file /etc/snmp/snmpd.conf sostituire:
#
#       agentAddress udp:127.0.0.1:161     >>>>>>>>      agentAddress udp:161
#  
#   in modo da abilitare la comunicazione tra agent e server SNMP anche al di fuori della 
#   rete di loopback.
#   Nel medesimo file di configurazione definire una vista che includa l'intero MIB
#
#         view     all     included     .1
#
#   Infine si deve abilitare la comunity ad operare su quella vista aggiungendo le seguenti
#   linee:
#
#       rocommunity public default -V all
#       rwcommunity supercom default -V all
#
#   In conclusione non resta altro che riavviare il demone SNMP con il seguente cmando
#
#       sudo systemctl restart snmpd

# SNMP WALK ----------------------------------------------------------------------------------------------------
# Il comando snmpwalk esegue una serie di getnext al fine di esplorare l'intero 
#   sottoalbero che gli si è specificato e visualizzarne tutte le entry.

snmpwalk -v 1 -c public <indirizzo_macchina> .1

#   Il comando sopra pone in output l'intera struttura del dell albero, 
#   da l'OID .1 (radice) sino alla fine.
#   I flag usati sono:
#       -v 1 ---------> che specifica la cersione del protocollo usata 1, 2c, 3, (per noi sempre 1).
#       -c public ----> specifica la community string per i protocolli v1 e v2c, (per noi sempre public).
#       <indirizzo_macchina> -----> indirizzo IP dell'agent a cui fare richiesta.
#       .1 -----------> nodo da cui partire la navigazione (.1 è la root dell'albero).
#   Da notare che il comando si presenta come un filtro per cui si presta volentieri al piping.

# SNMP GET -----------------------------------------------------------------------------------------------------------
# Il comando snmpget permette di visualizzare il valore di una specifica entry associata ad un OID.
#   esisitono 2 soli tipi di entry e possono essere identificati come:
#       scalari ---> sono entry che rappresentano un solo valore isolato, sono accessibili con OID.0
#       tabelle ---> sono entry aggregate e piu articolate da accedervi, il metodo è quello 
#                       di specificare prima del .0 il numero della colonna della tabella 
#                       ed il numero di riga della tabella, un esempio: 
#                           OID.1.1.0
#                       permette di accedere al valore della cella della colonna 1 riga 1 della 
#                       tabella specificata dall'OID 

snmpget -v 1 -c public <indirizzo_macchina> 'UCD-SNMP-MIB:memAvailReal.0'

#   Il comanddo sopra permette di accedere e visualizzare la entry identificata dal nome simbolico 
#   UCD-SNMP-MIB:memAvailReal che come si puo vedere all'interno del sito scaricato offline 
#   risulta equicalere all'OID .1.3.6.1.4.1.2021.4.6 che rappresenta l'ammontare di memoria fisica
#   disponibile sul sistema.
#   I flag usati sono:
#       -v 1 ---------------> che specifica la cersione del protocollo usata 1, 2c, 3, (per noi sempre 1).
#       -c public ----------> specifica la community string per i protocolli v1 e v2c, (per noi sempre public).
#       <indirizzo_macchina> -----> indirizzo IP dell'agent a cui fare richiesta.
#       'UCD-SNMP-MIB:memAvailReal.0' -----------> entry di cui si vuole sapere il valore.
#   Da notare che anche qui il comando si presenta come un filtro per cui si presta volentieri al piping.

# EXT TABLE ----------------------------------------------------------------------------------------------------------
# SNMP permette oltre che interrogare entry sul suo albero conteneti informazioni di carattere generale 
#   sul dispositivo dell'agent, permette inoltre di estendere il funzionamento dell'agent all'esecuzione 
#   di script customizzabili che ne accrescono enormemente le potenzialità.
#   Questa estensione avviene aggiungendo direttive "extend" al file di configurazione 
#   /etc/snmp/snmpd.conf ad esempio...
#   Ricavare la data dalla entry NET-SNMP-EXTEND-MIB::nsExtendOutputFull."currdate"
#
#       extend currdate /bin/date
#
#   Restituire il numero di processi in esecuzione sulla macchina
#
#       extend-sh sshnum ps haux | wc -l
#
#   Qui la differenza sta nel fatto che evocando un comando complesso (pipe) la parola chiave non è piu 
#   extend ma extend-sh, inoltre questo comando viene eseguito all'interrogazione della entry 
#   NET-SNMP-EXTEND-MIB::nsExtendOutputFull."sshnum".
#   Ovviamente al termine della modifica eseguita sul file di configurazione è necessario riavviare il 
#   sevizio snmpd con il comando:
#
#       sudo systemctl restart snmpd
#
#   E' fondamentale tenere amente che i valori restituiti sono cachati e il comando non viene rilanciato 
#   tutte le volte che la entry viene interrogata.
#   I metodo con cui è possibile interrogare la extTable è il classico comando snmpget:

snmpget -v 1 -c public <indirizzo_macchina> 'NET-SNMP-EXTEND-MIB::nsExtendOutputFull."sshnum"'

#   Nel caso si preferisca estrarre il solo valore pulito si usa

snmpget -v 1 -c public <indirizzo_macchina> 'NET-SNMP-EXTEND-MIB::nsExtendOutputFull."sshnum"' |
    awk -F 'STRING :' '{ print $2 }'

#   La problematica principale di questo sistema è la necessità di un editing piu specifico nel caso si 
#   vogliano lanciare comandi che richedano i permessi di root.
#
#   1) Editare il file di configurazione /etc/snmp/snmpd.conf per includere la nuova regola con l'aggiunta di 
#      /usr/bin/sudo:
#
#       extend nomeEntry /usr/bin/sudo <comando>
#
#   2) Aggiungere una regola in /etc/sudoers (tramite il comando 'sudo visudo') per permettere al demone
#      snmp di eseguire il comando come root senza dover inserire la password:
#
#       snmp ALL=NOPASSWD:<comando>
#
#   3) Testare l’esito di questa operazione impersonando l’utente snmp e cercando di eseguire il comando
#      che richiede permessi di root lanciando il comando da root:
#
#       su -s /bin/bash - snmp | <comando>
#
#      per poi vedere se il risultato è coerente con quanto ci si aspetta.

# INFO PROCESSI ---------------------------------------------------------------------------------------------------
# Un altro utile impiego di SNMP è quello di recuperare informazioni dai processi in esecuzione 
#   su un dato dispositivo dotato di agent SNMP.
#   Il primo passo per ottenere questo comportamento è quello di editare il file /etc/snmp/snmpd.conf
#   aggiungendo al file la seguente direttiva:
#
#       proc <nome_processo> <max_numero> <min_numero>
#
#   un esempio di monitoraggio del demone rsyslogd può essere:
#
#       proc rsyslogd 10 1
#
#   che vengono interpretate come: Il demone deve avere un numero di istanze compreso tra 1 e 10.
#   E' importante ricordarsi di riavviare il demone con il comando:
#
#       sudo systemctl restart snmpd
#
#   Ottenerer il numero di istanze di un processo può essere fondamentale per comprendere se esso è attivo
#   oppure no.
#   Il problema centrale è quello di ottenere l'id della tabella, questo viene fatto con l'impiego del 
#   comando:

ID = $(snmpwalk -v 1 -c public 10.9.9.1 "UCD-SNMP-MIB::prNames" | grep rsyslogd | awk -F "prNames." '{ print $2 }') | awk -F "=" '{ print $1 }'

#   Utilizzabile poi in seguito per ottenere il conteggio:

snmpget -v 1 -c public 10.9.9.1 "UCD-SNMP-MIB::prCount.$ID" | awk -F " INTEGER:" '{ print $2 }'

#   Si ricorda inoltre che il modulo "UCD-SNMP-MIB" contiene molte altre informazioni sui processi registrati,
#   tutte visualizzabili con la chiamata:

snmpwalk -v 1 -c public 10.9.9.1 .1 | grep UCD-SNMP-MIB

# FUNZIONI UTILI ----------------------------------------------------------------------------------------------------
# Ottiene il numero di istanze di un processo registrato tramite SNMP
# ARGOMENTI : $1 nome processo , $2 indirizzo macchina
function getProcessCount ()
{
    # Ottengo l'id del processo
    ID = $ ( snmpwalk -v 1 -c public $2 " UCD - SNMP - MIB :: prNames " \
        | grep " $1 " | awk -F " prNames . " ’{ print $2 } ’ \
        | awk -F " = " ’{ print $1 } ’ )
    
    # Utilizzo l'id per ottenere il conteggio
    NUM = $ ( snmpget -v 1 -c public $2 " UCD - SNMP - MIB :: prCount . $ID " \
    | awk -F " INTEGER : " ’{ print $2 } ’ )
    
    # Stampo il risultato
    echo $NUM
}

# Esempio di utilizzo :
NUMERO = $ ( getProcessCount " rsyslogd " " 10.9.9.1 " )
echo $NUMERO


