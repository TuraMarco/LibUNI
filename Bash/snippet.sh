#########################
#                       #
#      SNIPPET BASH     #
#                       #
#########################

# Controllare il numero di argomenti-------------------------------------------------------------------------------------------------------
if [ $# -ne 1 ]
then
        echo ARGUMENT ERROR
        exit
fi

# Installare un nuovo job schedulato in cron-----------------------------------------------------------------------------------------------
(crontab -l 2>/dev/null; echo "* * * * * /path/job argN") | crontab -

# Registrare un handler e porsi in attesa di un segnale------------------------------------------------------------------------------------
functionHandler(){}

trap 'functionHandler' USR1

while true;
do
        sleep 10
        wait $!
done

# Uso di getopts---------------------------------------------------------------------------------------------------------------------------
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
