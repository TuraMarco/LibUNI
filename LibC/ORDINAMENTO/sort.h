#ifndef _SORT_H
#define _SORT_H

#include"element.h"

/*
	Copiare la sezione adatta ed inserirla all'intrerno dell'header finale che 
	contien e anche il main.
*/

//================ PROTOTIPI FUNZIONI NAIVE_SORT ==================================
int trova_pos_max(io_element v[], int dim);
void scambia(io_element *x, io_element *y);
void neive_sort(io_element v[], int dim);
//=================================================================================

//=============== PROTOTIPI FUNZIONI BUBBLE_SORT ==================================
void bubble_sort(io_element v[], int dim);
//void scambia(io_element *x, io_element *y);
//=================================================================================

//============== PROTOTIPI FUNZIONI INSERT_SORT ===================================
void ins_ord(io_element v[], int pos);
void insert_sort(io_element v[], int dim);
//=================================================================================

//================ PROTOTIPI FUNZIONI MERGE_SORT ==================================
void merge(io_element v[], int i1, int i2, int fine, io_element vout[]);
void merge_sort(io_element v[], int first, int last, io_element vout[]);
//=================================================================================

//============== PROTOTIPI FUNZIONI QUICK_SORT ====================================
//void scambia(io_element *x, io_element *y);
void quick_sort(io_element a[], int dim);
void quick_sort_ric(io_element a[], int iniz, int fine);
//=================================================================================

#endif