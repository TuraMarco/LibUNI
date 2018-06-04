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
cd /path /della/directory   # Naviga nel path "/ path / della / directory "
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
find ! - name *. txt                    # Trovare tutti i file che NOT finiscono per .txt
find -size +100k -name *. txt           # Trovare tutti i file con dimensione superiore a 100k AND che finiscono per .txt
find - user las -o - name *. txt        # Trovare tutti i file dell'utente las OR che finiscono per .txts





