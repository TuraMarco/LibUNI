#ifndef _ELEMENT_H
#define _ELEMENT_H

#define MAX_STRING_LENGHT 256

//======================== BOOLEAN E TIPI UTILI======================================
#define BOOL int
#define TRUE 1
#define FALSE 0

typedef struct
{
	int anno;
	int mese;
	int giorno;
}
Data;

typedef struct
{
	int ore;
	int minuti;
	int secondi;
}
Time;
//========================== DEFINIZIONE TIPO IO_ELEMENT =========================
typedef struct
{
	int intero;
	float reale;
	char stringa[MAX_STRING_LENGHT];
	Data data;
	Time time;
} 
io_element;

//===================== DEFINIZIONE TIPO LIST_ELEMENT =============================
typedef struct
{
	int intero;
	float reale;
	char stringa[MAX_STRING_LENGHT];
	Data data;
	Time time;
} 
list_element;

typedef list_element element;

//================ PROTOTIPI FUNZIONI IO_ELEMENT ==================================
int compareData(Data d1, Data d2);
int compareTime(Time t1, Time t2);
int compareIoElement(io_element e1, io_element e2);

//================ PROTOTIPI FUNZIONI LIST_ELEMENT ================================
int compareListElement(list_element te1, list_element te2);
BOOL equalsListElement(list_element te1, list_element te2); 
void showListElement(list_element);

//================ PROTOTIPI FUNZIONI VARIE =======================================
int readField(char buffer[], int dimBuffer, char separatore, FILE *f);

#endif