# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

########################
#  PROCESSI & SEGNALI  #
########################

# PS ----------------------------------------------------------------------------------------------------------------------------------------------------------
# Il comando ps permette di ottenre informazioni dai processi attivi, 
#   le principali opzioni sono:
#       |- ax ---------> Visualizza tutti i processi, anche non propri
#       |- u ----------> Mostra gli utenti proprietari del processo
#       |- w ----------> Visualizza la riga di comando completa che ha originato il processo
#       |- f ----------> Visualizza i rapporti di discendenza tra i processi
#       |- U ----------> Mostra i processi dell utente (o piu utenti [separati da " "])
#       |- -p <pid> ----> Visualizza Solo il processo con questi pid (o più pid [separati da ","]) 
#       |_ -C <comando> ---------> Visualizza il processo creato con il comando

# SEGNALI -----------------------------------------------------------------------------------------------------------------------------------------------------
# I segnali sono uno strumento che permette a due processi di comunicare. Un processo pu`o infatti inviare ad un
#   altro un segnale che lo avvisa di un determinato evento.
#   Inoltre, un processo pu`o registrare presso il sistema operativo un handler apposito che, quando viene ricevuto
#   il segnale associato, viene eseguito.
#   Di seguito sono riportati i principali segnali:
#       |- SIGINT (2) -----> Interrompe un processo (CTRL + c)
#       |- SIGHUP (6) -----> Sveglia, spegne o riavvia un processo
#       |- SIGKILL (9) ----> Termina il processo (non ignorabile)
#       |- SIGTERM (15) -----> Termina il processo (ignorabile)
#       |- SIGTSTP (20) -----> Blocca il terminale (CTRL + z)
#       |- SIGSTOP (23) -----> Interrompe l'esecuzione (non ignorabile)
#       |- SIGUSR1 -----> Segnale personalizzabile 1
#       |_ SIGUSR2 -----> Segnale personalizzabile 2
#
#   Per iviare un segnale ad un processo si usa il comando kill con la sintassi:
#
#   kill -<SIGXXX> <pid>
#
#   Un esempio tra tutti può essere:
kill -SIGKILL 150  # Invia un segnale SIGKILL al processo con PID =150
#
#   L'operazione duale di intercettazione di un segnale  si fa con il comando trap,
#   questo comando permette inoltre di associare una funzione di handler alla cattura del segnale 
#   segunedo la sintassi:
#
#   trap '<handler>' <SIGXXX>
#
#   Un esempio di impiego può essere:
trap 'echo ciao' SIGUSR1
#   Spesso è però preferibile usare una funzione come handler al posto di un singolo comando, ad esempio
#
# Definisco l’ handler personalizzato
function logging () 
{
    case "$1" in
        start   ) echo started ;;
        stop    ) echo stop ;;
    esac
}
#
# Stoppa il logging quando viene ricevuto SIGUSR1
trap 'logging stop' SIGUSR1
logging start
while :
do
    # Eseguo le varie elaborazioni
    echo elaboro...
done

# JOB CONTROLL ----------------------------------------------------------------------------------------------------------------
# Per quanto riguarda il Job Control le due funzionalità base da comprendere sono:
#   |- Avviare un processo in BackGround
#   |_ Portare un processo in ForeGround
#   Per fare cio bisogna ricordarsi di:
<comando> &     # Avvia il comando in background
#   La shell ci restituisce il JOB_ID del processo creato che potremo in seguito usare per riportare 
#   il processo in foreground il seguente comando:
fg <JOB_ID>     # Riporta il processo con il JOB_ID specificato in foreground
#   E' anche possibile portare in background un processo gia lanciato, in questo caso si dovrà per prima cosa
#   bloccare il processo con una CTRL + z (SIGSTOP), questa operazione restituirà il JOB_ID del processo bloccato, a questo punto
#   con il comando:
bg <JOB_ID>     # Pone il processo con il JOB_ID indicato in background
#   Si riavvia il processo in background (SIGCONT).
#
# Un altra funzionalità base per quanto riguarda il Job Control è legata alla visualizzazione di tutti i jobs con il loro stato
#   cio viene fatto con il comando 
jobs            # Elenca tutti i jobs con il loro stato.
#
# Normalmente alla chiusura della schell tutti i processi attivi in foreground vengono terminati ricevendo un segnale SIGHUP,
#   per evitare questo comportamento è necessario sare il comando nohup, che rende il processo immune dal SIGHUP e ne scollega 
#   lo std_out, ridirigendolo sul file nohup.out (a defoult), la sintassi è la seguente.
nohup <command> &       # Esegue il comando in background e lo rende immune alla chiusura della shellù

# FUSER ----------------------------------------------------------------------------------------------------------------------
# Il comando fuser permette di visualizzare tutti i processi che usano un file specifico e se necessario inviare a 
#   tutti questi processi uno specifico segnale.
#   L'esempio di impiego base, quindi solo il listare i processi è il seguente:
fuser /path/to/file     # Visualizza i PID dei processi che usano un file
fuser -m /var           # Visualizza i processi che usano un intero filesystem o directory
#   Nel caso volessimo sfruttare fuser come generatore di segnali per i processi che usano file specifici useremo:
fuser -k -SIGUSR1 /path/to/file   # Invia un segnale di SIGUSR1 a tutti i processi che usano il file
#   A causa di una specifica formattazione dell'output può essere difficoltoso analizzarlo con awk o cut, per questo è piu 
#   semplice farlo sfruttando lsof

# LSOF -----------------------------------------------------------------------------------------------------------------------
# Il comando lsof permette di vedere tutti i file aperti nel sistema, alcuni esempi notevoili sono:
lsof                            # Visualizza tutti i file aperti dal sistema
lsof -u <username>              # Visualizza i file aperti da uno specifico user
lsof -p <PID>                   # Visualizza i file aperti da uno specifico processo
lsof + D /path/to/ dir      # Limitare l’ output di lsof ad una sola directory
lsof -i tcp                     # Listare tutti i file in base al tipo di connessione (tcp o udp)
lsof -i tcp -P                  # IMPORTANTE : Visualizza le porte numeriche e non simboliche