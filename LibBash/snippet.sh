# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

################
# SNIPPET BASH #
################

# READ ------------------------------------------------------------------------------------------------------
# Per leggere da STD_IN posso usare il comando 
read 
# a patto che lo std_in 
# non sia stato ridiretto, in caso contrario
read $(tty)
# Inoltre posso effettuare il parsing della riga letta
# in modo automatico
read FIRST REST
echo $FIRST
echo $REST
# in questo modo la read legge tutto cio che si trova 
# prima del IFS (input field separator) e lo associa 
# alla variabile FIRST, tutto cio che si trova dopo 
# alla variabile REST.

# SELECT & ARRAY --------------------------------------------------------------------------------------------------------------------------
# permette di realizzare menu a scielta multipla
PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit") # questo è un Array
select opt in "${options[@]}" # con ${options[@]} espando tutti gli elementi, posso usare * al posto di @
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice 3"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
# da bash4 sono supportati anche gli arrey associativi con 
declare -A ARRAY_ASSOCIATIVO
ARRAY_ASSOCIATIVO[key1]=value1
echo ${ARRAY_ASSOCIATIVO[key1]}

# CASE ------------------------------------------------------------------------------------------------------------------------------------
read VAR # legge da std_in e assegna alla variabile VAR
case "$VAR" in
	value1	) echo "valore 1";
	value2	) echo "valore 2";
	*		) echo "Non cade in nessuna delle precedenti"
;;
esac

# FOR -------------------------------------------------------------------------------------------------------------------------------------
read VAR
for VAR in 1 2 3 4
do 
	echo $VAR
done
# posso usare dopo l'in il comando 
$(seq 1.0 .01 1.1)
# per eseguire incrementi di 0.01 a partire da 1.0 sino ad arrivare ad 1.1
# oppure una sinstassi più simile al C
for (( i=0 ; i<10 ; i++ ))
do 
	echo $i
done

# WHILE -----------------------------------------------------------------------------------------------------------------------------------
while [ $i -le 10 ]
do
	echo $i
	i=$(expr $i+1)
done
# posso anche usare 
until [ $i -gt 10] ...
# non vi è alcuna differenza se non per la negazione della condizione


# CRON ------------------------------------------------------------------------------------------------------------------------------------
# Installare un nuovo job schedulato in cron
(crontab -l 2>/dev/null; echo "* * * * * /path/job argN") | crontab -

# Registrare un handler e porsi in attesa di un segnale------------------------------------------------------------------------------------
functionHandler()
{
	echo "E' stato ricevuto il segnale SIGUSR1"
}

trap 'functionHandler' USR1

while true;
do
        sleep 10
        wait $!
done

# Uso di getopts --------------------------------------------------------------------------------------------------------------------------
OPTIND=1 #resetto nel caso sia stato usato precedentemente nella shell
VERBOSE=0 #flag per output verboso disabilitato di default

show_help(){echo "Questo è l'output di aiuto."}

while getopts "h?vab:" opt; do
    case "$opt" in
    h|\?) #triggerato nel caso o usi il flag -h o sbaglio ad inserire un flag
        show_help
        exit 0
        ;;
    v) #abilita l'output verboso !!!DEVE ESSERE IL PRIMO FLAG!!!
        VERBOSE=1
        echo "Output verboso abilitato"
        ;;
    a) #flag senza argomenti
        echo "-a è stato triggerato e NON richiede argomenti."
        if [ $VERBOSE -eq 1 ] 
        then
            echo "Questo è l'output verboso di -a"
        fi
        ;;
    b) #flag con argomenti
        echo "-b è stato triggerato e l'argomento è $OPTARG."
        if [ $VERBOSE -eq 1 ] 
        then
            echo "Questo è l'output verboso di -b"
        fi
        ;;
    esac
done
