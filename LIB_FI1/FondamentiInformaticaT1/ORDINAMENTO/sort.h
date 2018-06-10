#ifndef _SORT_H
#define _SORT_H

#include"element.h"

/*
	Copiare la sezione adatta ed inserirla all'intrerno dell'header finale che 
	contiene anche il main.
*/

//================ PROTOTIPI FUNZIONI NAIVE_SORT ==================================
int trova_pos_max(io_struct v[], int dim);
void scambia(io_struct *x, io_struct *y);
void neive_sort(io_struct v[], int dim);
//=================================================================================

//=============== PROTOTIPI FUNZIONI BUBBLE_SORT ==================================
void bubble_sort(io_struct v[], int dim);
//void scambia(io_struct *x, io_struct *y);
//=================================================================================

//============== PROTOTIPI FUNZIONI INSERT_SORT ===================================
void ins_ord(io_struct v[], int pos);
void insert_sort(io_struct v[], int dim);
//=================================================================================

//================ PROTOTIPI FUNZIONI MERGE_SORT ==================================
void merge(io_struct v[], int i1, int i2, int fine, io_struct vout[]);
void merge_sort(io_struct v[], int first, int last, io_struct vout[]);
//=================================================================================

//============== PROTOTIPI FUNZIONI QUICK_SORT ====================================
//void scambia(io_struct *x, io_struct *y);
void quick_sort(io_struct a[], int dim);
void quick_sort_ric(io_struct a[], int iniz, int fine);
//=================================================================================

#endif