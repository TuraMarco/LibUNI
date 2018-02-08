#ifndef LIST_H
#define LIST_H 

#include "element.h" 

typedef struct list_element
{
	element value;
	struct list_element *next;
} item;

typedef item* list;

//======================= DEFINIZIONE PRIMITIVE LIST =======================
list emptyList(void); //crea lista vuota
BOOL empty(list); //verifica se una lista è vuota
list cons(element, list); //inserisce un elemento in una lista
element head(list);  //restituisce il primo elemento di una lista
list tail(list); //restituisce una lista privata del primo elemento
//==========================================================================

//==================== DEFINIZIONE FUNZIONI LIST ===========================
void showList(list l); //stampa la lista
void freeList(list l); //dealloca la lista
BOOL member(element e, list l); //vede se e' presente in l
int length(list l); //lunghezza lista
list concat(list l1, list l2); //attacca l2 in coda a l1
list reverse(list l); //inverte l'ordine degli elementi lista
list copy(list l); //copia la lista l
list canc(element e, list l); // elimina elemento e da l
list insOrd(element e, list l); //inserimento ordinato degli elementi
list inputOrdList(int n); //intervaccia utente inserimento odinato (POTREBBE ESSERE NECESSARIO MODIFICARLO)
list intersez(list l1, list l2); //trova elementi comuni a l1 e l2
list differ(list l1, list l2); //trova elementi non comuni a l1 e l2
//==========================================================================

#endif