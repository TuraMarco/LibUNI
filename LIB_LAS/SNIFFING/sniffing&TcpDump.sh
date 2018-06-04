# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

# TCP_DUMP ----------------------------------------------------------------------------
# tcpdump `e uno strumento che permette di intercettare e leggere i pacchetti TCP/IP in transito,
#   con la possibilità di filtrare secondo varie possibili specifiche.
#   I possibili flag utilizzabili con il comando tcpdump sono:
#       |- -i any ----------> Ascolta da tutte le interfacce di rete.
#       |- -i eth0 ---------> Ascolta sull'interfaccia eth0.
#       |- -l --------------> IMPORTANTE Line-buffered: Stampa un pacchetto appena lo riceve senza bufferizzare.
#       |- -n --------------> IMPORTANTE Non risolvere gli hostname, lascia IP numerico.
#       |- -t --------------> Stampa il tempo in un formato human-friendly.
#       |- -c [N] ----------> Legge solo N pacchetti e poi termina.
#       |- -w output.txt ---> Scrive i pacchetti nel file PCAP di output.
#       |- -r input.txt ----> Legge i pacchetti dal file PCAP.
#       |- -p --------------> No promiscuous mode.
#       |- -A --------------> Stampa i pacchetti in ASCII.
#       |_ -X --------------> Stampa i pacchetti in ASCII ed esadecimale.
#   Per rilevare i pacchetti in tempo reale è molto importante specificare le opzioni -l e -n che permettono rispettivamente di
#   non bufferizzare e di evitare la risoluzionedegli hostname.
#
# Per utilizzare al massimo le funzionalità del comando tcpdump è necessario comprendere l'utilizzo dei filtri, 
#   la man page di riferimento per la scrittura di questi è pcap-filter.
#
#   Per filtrare i pacchetti in base alla destinazione o alla sorgente:
tcpdump src 10.9.9.1        # Leggi i pacchetti in arrivo da 10.9.9.1
tcpdump dst 10.9.9.1        # Leggi i pacchetti destinati a 10.9.9.1
#
#   Filtrare i pacchetti in base al network
tcpdump net 10.9.9.0/24     # Leggi i pacchetti relativi al network 10.9.9.0/24
#
#   Filtra il traffico legato ad una porta
tcpdump port 1234           # Leggi i pacchetti relativi alla porta 1234
tcpdump src port 1234       # Leggi i pacchetti in arrivo dalla porta 1234
#
#   Filtra il traffico legato ad un protocollo
tcpdump icmp                # Leggi i pacchetti relativi al protocollo icmp
tcpdump tcp                 # Leggi i pacchetti relativi al protocollo tcp
#
#   Filtra il traffico in base alla dimensione del pacchetto
tcpdump less 32             # Leggi i pacchetti con dimensione minore di 32 byte
tcpdump greater 32          # Leggi i pacchetti con dimensione maggiore di 32 byte
#   E' anche possibile concatenare less e greater con il predicato logico 'and'.
#
#   Catturare i pacchetti con flag TCP particolari
tcpdump 'tcp[tcpflags] == tcp-syn'
tcpdump 'tcp[tcpflags] == tcp-fin'
#
# Esempi di funzionamento del comando tcpdump con concatenazione di filtri sono:
tcpdump -lnp dst 192.168.0.2 and not icmp
tcpdump -lnp src 10.9.9.1 and not dst port 22
tcpdump -lnp src 10.9.9.1 and (dst port 1234 or 22)