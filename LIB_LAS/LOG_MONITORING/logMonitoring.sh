# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

##############################
#  LOG_MONITORING & RSYSLOG  #
##############################

# RSYSLOG -----------------------------------------------------------------------------------------------------------------------------------------------------------------
# Il sottossistem di logging "rsyslog" è uno delle possibili scelte di logging in ambiente linux,
#   ed anche una delle applicazioni di monitoring storicamente più usate a questo scopo.
#   Ogni messaggio di log viene classificato con una coppia:
#
#       <facility>.<priority>
#
#   Dove facility rappresenta l'argomento che si stà trattando e si vuole loggare, può essere:
#       ∙ auth
#       ∙ authpriv
#       ∙ cron
#       ∙ daemon
#       ∙ ftp
#       ∙ kern
#       ∙ lpr
#       ∙ mail
#       ∙ news
#       ∙ syslog
#       ∙ user
#       ∙ uucp
#       ∙ local0 ..  local7
#   Mentre la priority è il livello di importanza del log, puo essere scelto tra i seguenti 
#   tipi di priority di importanza decrescente:
#       1) emerg
#       2) alert
#       3) crit
#       4) err
#       5) warning
#       6) notice
#       7) info
#       8) debug

# LOGGARE UN MESSAGGIO -------------------------------------------------------------------------------------------------------------
# Attraverso il comando "logger" è possibile loggare un messaggio arbitrario, in una facility specifica, 
#   con priorità a scelta.
#   La sintassi che il comando deve mantenere è la seguente:
logger -p <facility>.<priority> "messaggio_arbitrario_da_loggare"

# REDIRECT DEL LOG -------------------------------------------------------------------------------------------------------------------
# Il demone rsyslogd permette di eseguire il log dei messaggi ridirigendolo verso diverse destinazioni,
#   per fare ciò è necessario creare un file di configurazione: /etc/rsyslog.d/myLog.conf ed al suo
#   interno specificare la destinazione desiderata.
#   Le due impostazioni piu classiche prevedono:
#        |- Log in un file locale.
#        |_ Log su di un server remoto.
#
# Per salvare una specifica categoria di log all'interno di un server remoto, la configurazione 
#   deve prevedere una direttiva del tipo:
#       
#       <facility>.<priority>   /mio/path/logFile.log
#   
#   da notare che a separare le due stringhe vi è un tab.
#   Alcuni esempi:
local0.*        /var/log/attivita       # Salva tutti i log di tipo local0 con qualunque priorità.
kern.debug      /var/log/attivita       # Salva i log di tipo kernel da livello debug IN SU'.
kern.=debug     /var/log/attivita       # Salve i log kernel con livello ESATTAMENTE UGUALE a debug
#   RIcordarsi sempre che essendo rsyslog un demone standard in seguito all'editing del file di 
#   configurazione è necessario riavviare il servizio con il comando:
sudo systemctl restart rsyslog

# Per configurare un servizio di loging per salvare i messaggi su di un server remoto la cosa si fà
#   legermente piu elaborata, sono necessari due passaggi di configurazione:
#       |- Configurazione del CLIENT
#       |_ Configurazione del SERVER
#   
#   Per quanto riguarda il CLIENT è necessario creare il file /etc/rsyslog.d/myLog.conf ed inseririvi 
#   una direttiva di configurazione come riportata di seguito
local0.*        @192.168.56.203
#   In questo modo si specifica che i log del tipo local0 di qualunque priorità dovranno essere 
#   loggati sulla macchina remota che risponde all'ip specificato.
#   Al termine della configurazione riavviare il servizio come sempre con il comando
sudo systemctl restart rsyslog
#
#   Per la configurazione del SERVER invece deve essere creato il file /etc/rsyslog.d/myLog.conf e 
#   vi deve essere specificato dove salvare i log che gli vengono inoltrati con una direttiva che 
#   in questo caso è:
local0.*        /var/log/attivita
#   In seguito gli deve essere abilitata la ricezione dei log attraverso protocollo UDP (preferibile al TCP)
#   scommentando dal file di configurazione /etc/rsyslog.conf le righe
$ModLoad imudp
$UDPServerRun 514
#   Infine anche qui si riavvia il demone con il comando
sudo systemctl restart rsyslog




