#include"element.h"
#include"list.h"

//========================== FUNZIONI PRIMITIVE ======================================
list emptyList(void)
{
	return NULL; //NULL = lista vuota
}

BOOL empty(list l)
{
	if (l == NULL)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
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
	if (emptyList())
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
	if (emptyList())
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
		showListElement(head(l));
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
		if (equalsListElement(e, head(l)))
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
		if (equalsListElement(e,head(l)))
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
	//inserisce gli elementi con ordine (DAl PIU' PICCOLO AL PIU' GRANDE)
	if (empty(l))
	{
		return cons(e, l);
	}
	else
	{
		if (compareListElement(e, head(l)) <= 0)
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
			scanf("%d", &e); //modificare qui nel caso non si lavori con interi
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
