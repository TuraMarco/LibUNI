# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

#################
#  FILTRI BASE  #
#################

# LS --------------------------------------------------------------------------------------------------------------------------------------------
# Elenco i file in un direttorio (la home nel esempio), se viene omesso il 
#   path si prende di defoult il direttorio corrente: 
ls /home 
#   I flag maggiormentew usati sono:
#       |- -l ----> Abbina al nome le informazioni associate al file in formato tabellare
#       |- -h ----> Mostra la dimensione del file in versione piu leggibile
#       |- -a ----> Mostra tutto (includendo anche i file che iniziano con . e ..)
#       |- -A ----> Come -a, ma escludendo .. e .
#       |- -R ----> Percorre ricorsivamente la gerarchia
#       |- -r ----> Inverte l'ordine dell'elenco
#       |- -t ----> Ordina i file in base all'ora di modifica (dal piu recente)
#       |- -i ----> Indica gli i-number dei file
#       |- -F ----> Aggiunge alla fine del filename * agli eseguibili e / ai direttori
#       |- -d ----> Mostra le informazioni di un direttorio senza listare contenuto
#       |- -X ----> Lista alfabeticamente in base all'estensione
#       |- --full-time ----> Mostra la data di modifica completa (data , ora , sec , ecc )
#       |- --sort=extension ----> Ordina in base all ’ estensione
#       |- --sort=size  ----> Ordina in base alla dimensione del file
#       |_ --sort=time  ----> Ordina in base alla data di ultima modifica

# CD -----------------------------------------------------------------------------------------------------------------------------------------------
# Non è un comando linux ma una direttiva nativa della bash, permette di navigare 
#   all'interno dei direttori
cd                          # Torna nella home dell ’ utente corrente
cd /path /della/directory   # Naviga nel path "/path/della/directory"
cd ..                       # Naviga nel direttorio padre
cd -                        # Torna nel direttorio precedente

# LN -----------------------------------------------------------------------------------------------------------------------------------------------
# Comando che permette la creazione di HardLink o SimbolicLink, la differenza
#   tra i due sta nel fatto che il SimbolicLink è semplicemente un puntatore 
#   ad una entry mentre un HardLink è una struttura maggiormente complessa 
#   che oltre al riferimento al file mantiene anche alcune informazioni,
#   In generale è preferibile l'uso del SimbolicLink
ln /path/to/file/path/to/hardlink   # Crea un hardlink
ln -s /path/to/file/path/to/link    # Crea un link simbolico

# PRINTF -------------------------------------------------------------------------------------------------------------------------------------------
# Come la funzione di libreria C questo comando permette di stampare testo formattato,
#   la sintassi del comando è la seguente  
printf <FORMATO> <ARGOMENTI>
#   con la stringa formato che supporta tutte le wildcard compatibili con la funzione C quindi:
#       |- %s ---> STRINGA
#       |- %d ---> INTERO
#       |- %x ---> INTERO ESADECIMALE
#       |- %o ---> INTERO OTTALE
#       |_ %f ---> FLOAT (precisione a 6 caratteri)
#   Un esempio di utilizzo può essere:
printf "Nome: %s\nEta: %d" pippo 16

# PWD ----------------------------------------------------------------------------------------------------------------------------------------------
# Permette di stampare il diettorio corrente in formato assoluto
pwd 

# DU -----------------------------------------------------------------------------------------------------------------------------------------------
# Viene usato per ottenere informazioni riguardo all'uso dello spazio di 
#   archiviazione per un file o una directory, i flag piu usati sono:
#       |- -h ---> Mostra le dimensioni in modo facilmente leggibile
#       |- -s ---> Mostra il sommario (totale) della directory
#       |- --max-depth ---> Massima profondità di esplorazione
#       |_ --exclude="*.txt" ---> Esclude tutti i file che rispettano il pattern (non supporta RegEx)
#   Esempi notevoli di utilizzo sono:
du /path/directory          # Stampa la dimensione di ogni nodo dell'albero
du | sort -nr | head -10    # Mostra i 10 file piu voluminosi nel direttorio corrente (PIPE)

# FIND ---------------------------------------------------------------------------------------------------------------------------------------------
# Comando che permette di trovare i file e le directory all'interno del sistema.
#   Permette di specificare filtri per individuare i file secondo diversi parametri,
#   Questi sono solo alcuni degli esempi notevoli:
find /percorso/directory -name *.txt    # Trovare tutti i file che finiscono per .txt nella directory specificata
find -size +100k                        # Trovare tutti i file con dimensione superiore a 100k
find -user las                          # Trovare tutti i file dell'utente las
find -group las                         # Trovare tutti i file del gruppo las
find -type d                            # Trovare tutti i direttori
find -type f -perm -110                 # Tutti i file eseguibili dall'utente e dal gruppo
find -type f -perm /110                 # Trovare tutti i file che hanno esattamente il permesso 110
#   E' possibile far eseguire un comando su ogni file trovato in questo modo tramite la xargs
find . | xargs ls -lh                   # Stampare le informazioni di ogni file trovato tramite ls
#   E' inoltre possibile combinare le opzioni con flag specifici che assolvono al ruolo di predicati logici
#       |- AND ----> Due comandi vengono messi in AND automaticamente se accodati senza separatori
#       |- OR -----> Due comandi sono posti in OR se tra loro viene usato come separatore il flag '-o'
#       |_ NOT ----> Viene negato il filtro di ricerca ponendo prima di esso '!'
find ! -name *. txt                    # Trovare tutti i file che NOT finiscono per .txt
find -size +100k -name *. txt          # Trovare tutti i file con dimensione superiore a 100k AND che finiscono per .txt
find -user las -o - name *. txt        # Trovare tutti i file dell'utente las OR che finiscono per .txts

# GREP ----------------------------------------------------------------------------------------------------------------------------------------------------
# Comando atto al filtraggio e rierca dei pattern all'interno difile e std_io, la versione estesa 'egrep' 
#   possiede la compatibilità completa con le RegularExpression, mentre la 'grep' solo con una sottoparte. 
#   I fleg più usati sono:
#       |- -e ---> abilita le RegEx, lo rende completamente identico ad egrep
#       |- -v ---> Inverti il match (escludi le righe che soddisfano il pattern)
#       |- -c ---> Conteggio del numero di righe che soddisfano il pattern
#       |- -i ---> Effettua la ricerca CASE-INSENSITIVE
#       |- -w ---> Cerca parole intere e NON sottostringhe
#       |- -l ---> Mostra solo i nomi dei file (senza righe con match)
#       |- -r <root> ---> esegue una ricerca ricorsiva dei pattern a partire da <root>
#       |- -q ---> Non stampare a video l'ouput (utile negli IF)
#       |- -n ---> Mostra i numeri di riga dei match
#       |- -o ---> Mostra solo la stringa che fa match, e non la riga intera
#       |- -B <n> ---> Stampa anche le <n> righe precedenti al match
#       |- -A <n> ---> Stampa anche le <n> righe successive al match
#       |_ --line-buffered ---> Disabilita l'output buffer e stampa subito le righe
grep -e "<RegEx>" filename.txt          # Stampo le righe di un file che contengono la parola "ciao"
cat filename.txt | grep -e "<RegEx>"    # Grep è un filtro quindi questa è equivalente a quella spra
#
#   Il valore di ritorno della grep è 0 se il pattern è stato trovato, 1 altrimenti, è quindi possibile 
#   sfruttarla in un if come controllo, ricordandosi di usare il flag -q per non stampare a video l'output 
A=ciaone
if echo $A | grep -q "ciao"
then
    echo A contiene ciao
fi
#
#   #########################
#   #   Regular Expression  #
#   #########################   
#   Vedi il cheat sheet in RegEx.pdf per approfondire
#   
#   //AtomiSpeciali
#   . ---> indica qualunque carattere
#   ^ ---> indica l'inizio della linea
#   $ ---> indica il fine linea
#   [abc] ---> indica qualunque carattere tra a,b o c
#   [a-z] ---> indica qualunque carattere tra a e z
#   [^dc] ---> indica qualunque carattere che non è ne d ne c
#
#   //Moltiplicatori
#   {n,m} ---> indica da n ad m occorrenze dell'atomo che lo precede
#   ? ---> indica 0 o 1 occorrenza dell'atomo che lo precede
#   * ---> indica 0 o più occorrenze dell'atomo che lo precede
#   + ---> indica 1 o più occorrenze dell'atomo che lo precede

# CUT -------------------------------------------------------------------------------------------------------------------------------------------------------
# Comando che permette di estrarre porzioni di righe passate o attraverso 
#   std_in o con un file.
#   In base al tipo di flag che si usa si estrarranno o un certo numero di caratteri 
#   o un campo specifico delimitato da un carattere separatore.
#
#   Per estrarre uno o più caratteri si usa il flag -c come nei seguenti esempi:
cut -c10 file.txt       # Restituisci il decimo carattere di ogni riga del file
cut -c5 -10 file.txt    # Restituisci i caratteri dal quinto al decimo
cut -c-20 file.txt      # Restiuisci i caratteri dall ’ inizio fino al 20 esimo
cut -c5 - file . txt    # Resituisci i caratteri dal quinto in poi
#
#   Per estrarre invece capi delimitati da separatori si usano il flag -d e -f con la sintassi:
#       
#   cut -d<carattere_delimitatore> -f<elenco_campi>S
#   
#   Questi sono alcuni esempidi uso:
cut -d, -f1             # Estraggo il primo campo, separati da una virgola
cut -d ' ' -f1,3        # Estraggo il primo ed il terzo campo, separati da uno spazio
#   Altro flag utile in questo caso è -s che permette di escludere tutte le righe in cui
#   non compare il carattere delimitatore.
#   Nel caso non sia sufficente un singolo carattere come delimitatore è utile passare 
#   ad utilizzare il comando awk.

# AWK ---------------------------------------------------------------------------------------------------------------------------------------------------------
# Il comando awk è sostitutivo al comando cut, permette di estrarre dei campi da una riga 
#   usando stringhe arbitrarie come separatori, e molto altro.
#   Alcuni esempi di utilizzo sono:
awk '{ print $1 }'          # Estrai il primo campo dalla riga, separato da uno spazio
awk -F "," '{ print $2 }'   # Estraggo il secondo campo , separato da una virgola
#
#   Posso anche eseguire estrazzioni più complesse come ad esempio:
#   INPUT: campo1=pippo campo2=pluto
#   Vogliamo estrarre "pippo"
awk -F "campo1=" '{ print $2 }' | awk -F " campo2=" '{ print $1 }'
#
#   In caso si vogliano filtrare dei campi in real-time, pu`o essere comoda 
#   l’opzione -W interactive che evita il buffering.

# SED ----------------------------------------------------------------------------------------------------------------------------------------------------------
# Come il comando awk il comando sed è un ricchissimo linguaggio di manipolazione stringhe, 
#   che permette innanzitutto di eseguire sostituzioni all interno di un file o dello std_in 
#   di un processo.
#   Alcuni esempi che mostrano il funzionamento sono:
sed 's/pippo/pluto/' file.txt   # Sostituisci la prima occorrenza di pippo con pluto per ogni riga del file.txt
sed 's/pippo/pluto/g' file.txt  # Sostituisci TUTTE le occorrenze di pippo con pluto
sed 's/pippo/pluto/gi' file.txt # Sostituisci tutte le occorrenze di pippo con pluto CASE_INSENSITIVE
sed 's/^/INIZIO: /' file.txt     # Aggiungi all'inizio di ogni riga "INIZIO: "


# SORT ---------------------------------------------------------------------------------------------------------------------------------------------------------
# Questo comando è utile per ordinare righe in un file o sullo std_in, di seguito sono 
#   riportati alcuni esempi notevoli
sort file.txt               # Ordina alfabeticamente le righe del file
sort -n file.txt            # Ordina numericamente le righe del file
sort -u file.txt            # Ordina le righe del file ed elimina i duplicati
sort -r file.txt            # Ordina in ordine inverso
#   Un altro comodo impiego del comando sort è legato all'ordinamento di secondo uno 
#   specifico campo e non all'intera riga, seguendo la sintassi:
#
#   sort -t<delimitatore> -k <campo>,<campo>[n]
#
#   Un esempio pratico può essere il seguente che permette di ordinare degli indirizzi IP
sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n
#   Un fatto importante da tenere a mente, è che sort deve consumare l'intero output, se vine 
#   alimentato da std_in, prima di produrre a sua volta un risultato 

# UNIQ -----------------------------------------------------------------------------------------------------------------------------------------------------------
# Comando che permette di rimuovere le righe duplicate CONTIGUE, è quindi bene farlo 
#   precedere da un comando sort, al fine di raggruppare gli eventuali duplicati non contigui.
#   Alcuni esempi notevoli di utilizzo sono:
uniq            # Elimina i duplicati CONTIGUI
uniq -c         # Indica il numero di occorrenze per ogni duplicato
uniq -d         # Mostra SOLO i duplicati

# HEAD ----------------------------------------------------------------------------------------------------------------------------------------------------
# Il comando head permette di mostrare le prime 'n' righe di un file o dello
#   std_in nel caso di un impiego all'interno di una PIPE.
#   DI seguito alcuni esempi notevoli:
head -2 file.txt        # Mostra solo le prime 2 righe del file
head -c 5 file.txt      # Mostra solo i primi 5 caratteri del file

# TAIL ----------------------------------------------------------------------------------------------------------------------------------------------------
# Come il comando head il comando tail isola e restituisce un insieme di righe, con la differenza 
#   che invece di essere le prime 'n' sono le ultime 'n' di un file o dello std_in, ad esempio:
tail -3 file.txt        # Mostra le ultime 3 righe del file
#   Un utile impiego dle comando tail puo essere l’opzione -f che permette di lasciare aperto un 
#   file e di visualizzare in tempo reale le aggiunte ad esso.
#   A riguardo, `e comodo un altro trucchetto nel caso sia necessario visualizzare solo le righe 
#   che sono state aggiunte dall’avvio del comando in poi, e non quelle gi`a presenti nel file:
tail -n 0 -f file.txt   # Non leggo nessuna riga dal file, ma ricevo quelle nuove
#   Inoltre pu`o anche essere utile che tail termini quanto un altro processo termina, 
#   per questo usare l’opzione --pid
tail -f -- pid 1234     # Continua a leggere fino a che il processo 1234 non termina


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




