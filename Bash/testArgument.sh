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
fi

if [ ! -e $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente."
fi

if [ ! -f $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o regolare."
fi

if [ ! -r $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o leggibile."
fi

if [ ! -s $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o di dimensione maggiore di 0."
fi

if [ ! -w $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o scrivibile."
fi

if [ ! -x $1 ]
then
        echo "Errore: L'argomento passato non è un file esistente o eseguibile."
fi

if [ -z $1 ]
then
        echo "Errore: La stringa passata è vuota."
fi

###############
# TEST BINARI #
###############

if [ $FILE1 -nt $FILE2 ]
then
        echo "Avviso: $FILE1 è più nuovo di $FILE2."
fi

if [ $FILE1 -ot $FILE2 ]
then
        echo "Avviso: $FILE1 è più vecchio di $FILE2."
fi

if [ $STRING1 = $STRING2 ]
then
        echo "Avviso: STRING1 è uguale a STRING2."
fi

if [ $STRING1 != $STRING2 ]
then
        echo "Avviso: STRING1 è diversa a STRING2."
fi

if [ $1 -eq $2 ]
then
        echo "Avviso: L'argomento 1 è uguale all'argomento 2."
	# Al posto di -eq (uguaglianza) si può usare
	#	-ne ---> disuguaglianza
        #	-lt ---> strettamente minore
        #	-le ---> minore o uguale
        #	-gt ---> strettamente maggiore
        #	-ge ---> maggiore uguale
fi




