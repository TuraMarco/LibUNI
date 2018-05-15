#!/bin/bash

##############
# TEST UNARI #
##############

# $0 		---> nome dello script
# $1, $2,... 	---> argomenti dello script
# $#		---> numero di argomenti passati
# "$*"		---> espanso in "$1 $2 ..."
# "$@"		---> espanso in "$1" "$2" ...

${1:?"Errore: L'argomento passato è NULL."}

if [ ! -d $1 ]
then
	echo "Errore: L'argomento passato non è una directory esistente."
	exit
fi

if [ ! -e $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente."
	exit
fi

if [ ! -f $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o regolare."
		exit
fi

if [ ! -r $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o leggibile."
	exit
fi

if [ ! -s $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o di dimensione maggiore di 0."
	exit
fi

if [ ! -w $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o scrivibile."
	exit
fi

if [ ! -x $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o eseguibile."
	exit
fi

if [ -z $1 ]
then
        echo "Errore: La stringa passata è vuota."
	exit
fi

###############
# TEST BINARI #
###############

if [ $FILE1 -nt $FILE2 ]
then
        echo "Avviso: $FILE1 è più nuovo di $FILE2."
elif [ $FILE1 -ot $FILE2 ]
then
        echo "Avviso: $FILE1 è più vecchio di $FILE2."
elif [ $STRING1 = $STRING2 ]
then
        echo "Avviso: STRING1 è uguale a STRING2."
elif [ $STRING1 != $STRING2 ]
then
        echo "Avviso: STRING1 è diversa a STRING2."
else
		echo "Questo è l'else."
fi

if [ $# -ne 1 ]
then
        echo "Errore: Sono stati passati un numero di argomenti diverso da 1."
	exit
	# Al posto di -ne (disuguaglianza) si può usare
	#	-eq ---> uguaglianza
        #	-lt ---> strettamente minore
        #	-le ---> minore o uguale
        #	-gt ---> strettamente maggiore
        #	-ge ---> maggiore uguale
fi




