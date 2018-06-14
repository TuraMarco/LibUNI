#include"element.h"
#include"list.h"

//VEDERE SE SERVONO
#include <stdlib.h>
#include <stdio.h>


//////////////////////////////////////
//		FUNZIONI DI LIBRERIA		//
//////////////////////////////////////

//========================== FUNZIONI PRIMITIVE ======================================
list emptyList(void)
{
	return NULL; //NULL = lista vuota
}

BOOL empty(list l)
{
	return (l == NULL);
}

list cons(element e, list l)
{
	list t;

	t = (list)malloc(sizeof(item));
	t->value = e;
	t->next = l;

	return t;
}

element head(list l)
{
	if (empty(l))
	{
		printf("La lista e' vuota.");
		abort();
	}
	else
	{
		return l->value;
	}
}

list tail(list l)
{
	if (empty(l))
	{
		printf("La lista e' vuota.");
		abort();
	}
	else
	{
		return l->next;
	}
}
//===================================================================================

//============================= FUNZIONI LISTA ======================================
void showList(list l)
{
	//stampa tutti gli elementi di una lista
	printf("{\n");
	while (!empty(l))
	{
		printf("\t[");
		showListStruct(head(l));
		printf("]\n");

		l = tail(l);
	}
	printf("}\n");
}

void freeList(list l)
{
	//dealloca una lista
	if (empty(l))
	{
		return;
	}
	else 
	{
		freelist(tail(l));
		free(l);
	}
	return;
}

BOOL member(element e, list l)
{
	//guarda se un elemento e' presente in una lista
	while (!empty(l))
	{
		if (equalsListStruct(e, head(l)))
		{
			return TRUE;
		}
		else
		{
			l = tail(l);
		}
	}
	return FALSE;
}

int length(list l)
{
	//ritorna la lunghezza della lista

	if (empty(l))
	{
		return 0;
	}
	else
	{
		return 1 + length(tail(l));
	}
}

list concat(list l1, list l2)
{
	//unisce 2 liste in una sola (prima l1 poi l2)
	if (empty(l1))
	{
		return l2;
	}
	else
	{
		return cons(head(l1), concat(tail(l1), l2));
	}
}

list reverse(list l)
{
	//inverte gli elementi di una lista
	if (empty(l))
	{
		return emptyList();
	}
	else
	{
		return concat(reverse(tail(l)), cons(head(l), emptyList()));
	}
}

list copy(list l)
{
	//ritorna una copia della lista passata per argomento
	if (empty(l))
	{
		return l;
	}
	else
	{
		return cons(head(l), copy(tail(l)));
	}
}

list canc(element e, list l)
{
	//elimina un elemento e dalla lista l
	if (empty(l))
	{
		return emptyList();
	}
	else
	{
		if (equalsListStruct(e,head(l)))
		{
			return tail(l);
		}
		else
		{
			return cons(head(l), canc(e, tail(l)));
		}
	}
}

list insOrd(element e, list l)
{
	//inserisce gli elementi con ordine (DAl PIU' PICCOLO AL PIU' GRANDE, se serve il contrario usa dopo reverse();)
	if (empty(l))
	{
		return cons(e, l);
	}
	else
	{
		if (compareListStruct(e, head(l)) <= 0)
		{
			return cons(e, l);
		}
		else
		{
			return cons(head(l), insOrd(e, tail(l)));
		}
	}
}

list inputOrdList(int n) //'n' elementi da inserire (POTREBBE ESSERE NECESSARIO MODIFICARLO)
{

	//Interfaccia del inserimento ordinato
	element e;
	if (n<0)
	{
		printf("Errore: si cerca di inserire un numero minore di 0 elementi.\n");
		abort();
	}
	else
	{
		if (n == 0)
		{
			return emptyList();
		}
		else
		{
			printf("Inserire elemento:\n");	
			//scanListStruct(&e); //scommentare e scrivewre la classe
			return insOrd(e, inputOrdList(n - 1));
		}
	}
}


list intersez(list l1, list l2)
{
	//trova elementi comuni a l1 e l2
	list ris = emptyList(); 
	list temp = emptyList();
	int p = 0;

	if (empty(l1) || empty(l2))
	{
		return emptyList();
	}
	else
	{
		while (!empty(l1))
		{
			if (member(head(l1), l2))
			{
				p = 0;
				while (!empty(temp))
				{
					p = 0;
					if (member(head(l1), temp))
					{
						p = 1;
					}

					temp = tail(temp);
				}
				if (!p)
				{
					ris = cons(head(l1), ris);
				}
			}

			l1 = tail(l1);
			temp = copy(ris);
		}
	}
	return ris;
}

list differ(list l1, list l2)
{
	//trova elementi non comuni a l1 e l2
	list ris = emptyList();
	list temp = emptyList();
	int p = 0;

	if (empty(l1))
	{
		return emptyList();
	}
	else
	{
		if (empty(l2))
		{
			return l1;
		}
		else
		{
			while (!empty(l1))
			{
				if (!member(head(l1), l2))
				{
					p = 0;
					while (!empty(temp))
					{
						p = 0;

						if (member(head(l1), temp))
						{
							p = 1;
						}
							
						temp = tail(temp);
					}
					if (!p)
					{
						ris = cons(head(l1), ris);
					}
				}
				l1 = tail(l1);
				temp = copy(ris);
			}
		}
	}
	return ris;
}
//===================================================================================

//=================================== ALTRE =========================================
void scanListStruct(elementt * e)
{
	//TODO 
	// Da editare in base al compito

	//leggo un elemento della lista da terminale

	// printf("Inserire un intero: ")
	// fcanfs(0, "%d", e.intero);

	// printf("Inserire un reale: ")
	// fcanfs(0, "%f", e.reale);

	// printf("Inserire una stringa: ")
	// fcanfs(0, "%s", e.stringa);

	// printf("Inserire una data (nel formato d/m/yyyy): ")
	// fcanfs(0, "%d/%d/%d", e.data.giorno, e.data.mese, e.data.anno);

	// printf("Inserire un orario: (nel formato h:m:s): ")
	// fcanfs(0, "%d:%d:%d", e.time.ore, e.time.minuti, e.time.secondi);
}
//===================================================================================