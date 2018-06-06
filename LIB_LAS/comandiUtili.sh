# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

# LS --------------------------------------------------------------------------
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

# CD -----------------------------------------------------------------------------
# Non è un comando linux ma una direttiva nativa della bash, permette di navigare 
#   all'interno dei direttori
cd                          # Torna nella home dell ’ utente corrente
cd /path /della/directory   # Naviga nel path "/path/della/directory"
cd ..                       # Naviga nel direttorio padre
cd -                        # Torna nel direttorio precedente

# LN -----------------------------------------------------------------------------
# Comando che permette la creazione di HardLink o SimbolicLink, la differenza
#   tra i due sta nel fatto che il SimbolicLink è semplicemente un puntatore 
#   ad una entry mentre un HardLink è una struttura maggiormente complessa 
#   che oltre al riferimento al file mantiene anche alcune informazioni,
#   In generale è preferibile l'uso del SimbolicLink
ln /path/to/file/path/to/hardlink   # Crea un hardlink
ln -s /path/to/file/path/to/link    # Crea un link simbolico

# PRINTF -------------------------------------------------------------------------
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

# PWD ----------------------------------------------------------------------------
# Permette di stampare il diettorio corrente in formato assoluto
pwd 

# DU -----------------------------------------------------------------------------
# Viene usato per ottenere informazioni riguardo all'uso dello spazio di 
#   archiviazione per un file o una directory, i flag piu usati sono:
#       |- -h ---> Mostra le dimensioni in modo facilmente leggibile
#       |- -s ---> Mostra il sommario (totale) della directory
#       |- --max-depth ---> Massima profondità di esplorazione
#       |_ --exclude="*.txt" ---> Esclude tutti i file che rispettano il pattern (non supporta RegEx)
#   Esempi notevoli di utilizzo sono:
du /path/directory          # Stampa la dimensione di ogni nodo dell'albero
du | sort -nr | head -10    # Mostra i 10 file piu voluminosi nel direttorio corrente (PIPE) 

# FIND ---------------------------------------------------------------------------
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

# GREP ----------------------------------------------------------------------------------
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

# CUT -------------------------------------------------------------------------------------
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

# AWK ---------------------------------------------------------------------------------------
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









