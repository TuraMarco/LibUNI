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

//========================== DEFINIZIONE TIPO IO_STRUCT =========================
typedef struct
{
	//TODO 
	// Dsa editare in base al compito
	int intero;
	float reale;
	char stringa[MAX_STRING_LENGHT];
	Data data;
	Time time;
}
io_struct;

//===================== DEFINIZIONE TIPO LIST_STRUCT =============================
typedef struct
{
	//TODO 
	// Dsa editare in base al compito
	int intero;
	float reale;
	char stringa[MAX_STRING_LENGHT];
	Data data;
	Time time;
}
list_struct;

typedef list_struct element;

//////////////////////////////////////
//		FUNZIONI DI LIBRERIA		//
//////////////////////////////////////

//================ PROTOTIPI FUNZIONI IO_STRUCT ==================================
int compareData(Data d1, Data d2);
void showData(Data d);
int compareTime(Time t1, Time t2);
void showTime(Time t);
int compareIoStruct(io_struct e1, io_struct e2);
void showIoStruct(io_struct e);
void showIoStructArray(io_struct * array, int dim);

//================ PROTOTIPI FUNZIONI LIST_STRUCT ================================
int compareListStruct(list_struct te1, list_struct te2);
BOOL equalsListStruct(list_struct te1, list_struct te2);
void showListStruct(list_struct te);
void showAllListStruct(list_struct te);


#endif