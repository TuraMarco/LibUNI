################
#     SNMP     #
################
# Il protocollo SNMP permette di gestire in maniera semplificata diverse risorse di rete. 
#   Ogni oggetto è rappresentato da un OID univoco ed incluso in un database detto MIB.

# PREDISPOSIZIONE ---------------------------------------------------------------------------------------
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

# SNMP WALK -------------------------------------------------------------------------------------------
# Il comando snmpwalk esegue una serie di getnext al fine di esplorare l'intero 
#   sottoalbero che gli si è specificato e visualizzarne tutte le entry.

snmpwalk -v 1 -c public 10.9.9.1 .1

#   Il comando sopra pone in output l'intera struttura del dell albero, 
#   da l'OID .1 (radice) sino alla fine.
#   I flag usati sono:
#       -v 1 ---------> che specifica la cersione del protocollo usata 1, 2c, 3, (per noi sempre 1).
#       -c public ----> specifica la community string per i protocolli v1 e v2c, (per noi sempre public).
#       10.9.9.1 -----> indirizzo IP dell'agent a cui fare richiesta.
#       .1 -----------> nodo da cui partire la navigazione (.1 è la root dell'albero).
#   Da notare che il comando si presenta come un filtro per cui si presta volentieri al piping.

# SNMP GET --------------------------------------------------------------------------------------------
# Il comando snmpget permette di visualizzare il valore di una specifica entry associata ad un OID.
#   esisitono 2 soli tipi di entry e possono essere identificati come:
#       scalari ---> sono entry che rappresentano un solo valore isolato, sono accessibili con OID.0
#       tabelle ---> sono entry aggregate e piu articolate da accedervi, il metodo è quello 
#                       di specificare prima del .0 il numero della colonna della tabella 
#                       ed il numero di riga della tabella, un esempio: 
#                           OID.1.1.0
#                       permette di accedere al valore della cella della colonna 1 riga 1 della 
#                       tabella specificata dall'OID 

snmpget -v 1 -c public 192.168.56.203 'UCD-SNMP-MIB:memAvailReal.0'

#   Il comanddo sopra permette di accedere e visualizzare la entry identificata dal nome simbolico 
#   UCD-SNMP-MIB:memAvailReal che come si puo vedere all'interno del sito scaricato offline 
#   risulta equicalere all'OID .1.3.6.1.4.1.2021.4.6 che rappresenta l'ammontare di memoria fisica
#   disponibile sul sistema.
#   I flag usati sono:
#       -v 1 ---------------> che specifica la cersione del protocollo usata 1, 2c, 3, (per noi sempre 1).
#       -c public ----------> specifica la community string per i protocolli v1 e v2c, (per noi sempre public).
#       192.168.56.203 -----> indirizzo IP dell'agent a cui fare richiesta.
#       'UCD-SNMP-MIB:memAvailReal.0' -----------> entry di cui si vuole sapere il valore.
#   Da notare che anche qui il comando si presenta come un filtro per cui si presta volentieri al piping.

