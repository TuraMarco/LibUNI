#ifndef _MAIN_H
#define _MAIN_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "element.h"
#include "list.h"
#include "sort.h"


/*=================================================*/
//						ARRAY                      //
/*=================================================*/
//=========== LEGGI UNO ALLA VOLTA ===================
io_struct leggiUno(FILE * fp);
BOOL isLetturaCorretta(io_struct element);
io_struct * leggiTuttiUnoAllaVolta(char * fileName, int * dim);

//=========== LEGGI IN UNA VOLTA =====================
io_struct * leggiTuttiInsieme(char * fileName, int * dim);

//=========== STAMPA =================================
void stampaTutti(io_struct * v, int dim);

/*=================================================*/
//						ARRAY                      //
/*=================================================*/
//=========== LEGGI UNO ALLA VOLTA ===================
list_struct leggiUnoList(FILE * fp);
BOOL isLetturaCorretta(list_struct element);
list leggiTuttiUnoAllaVolta(char * fileName);

//=========== LEGGI IN UNA VOLTA =====================
list leggiTuttiInsieme(char * fileName);

/*=================================================*/
//			        ALTRE FUNZIONI                 //
/*=================================================*/
int readField(char buffer[], int dimBuffer, char separatore, FILE *f);

#endif