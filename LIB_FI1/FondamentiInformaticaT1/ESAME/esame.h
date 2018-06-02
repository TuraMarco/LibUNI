#ifndef _ORDINI_H
#define _ORDINI_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "element.h"
#include "list.h"

/*=================================================*/
//						ARRAY                      //
/*=================================================*/
//=========== LEGGI UNO ALLA VOLTA ===================
io_element leggiUno(FILE * fp);
BOOL isLetturaCorretta(io_element element);
io_element * leggiTuttiUnoAllaVolta(char * fileName, int * dim);

//=========== LEGGI IN UNA VOLTA =====================
io_element * leggiTuttiInsieme(char * fileName, int * dim);

//=========== STAMPA =================================
void stampaTutti(io_element * v, int dim);

/*=================================================*/
//						ARRAY                      //
/*=================================================*/
//=========== LEGGI UNO ALLA VOLTA ===================
list_element leggiUnoList(FILE * fp);
BOOL isLetturaCorretta(list_element element);
list leggiTuttiUnoAllaVolta(char * fileName);

//=========== LEGGI IN UNA VOLTA =====================
list leggiTuttiInsieme(char * fileName);

#endif