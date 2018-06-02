#include"sort.h"

//========================== FUNZIONI NAIVE_SORT ==================================
int trova_pos_max(io_element v[], int dim)
{
	//ritorna la posizione del elemento numerico piu alto in un array
	int i;
	int posmax = 0;

	for (i = 0; i < dim; i++)
	{
		if (compareIoElement(v[i], v[posmax]) < 0)
		{
			posmax = i;
		}
	}

	return posmax;
}

void scambia(io_element *x, io_element *y)
{
	io_element t;

	t = *x;
	*x = *y;
	*y = t;

	return;
}

void neive_sort(io_element v[], int dim) 
{
	int p;
	while (dim > 1)
	{
		p = trova_pos_max(v, dim);

		if (p < dim - 1)
		{
			scambia(&v[p], &v[dim - 1]);
		}
		dim--;
	}

	//scambi nel caso peggiore => dim*(dim-1)/2
}
//=================================================================================

//========================== FUNZIONI BUBBLE_SORT =================================
/*
void scambia(io_element *x, io_element *y)
{
	io_element t;

	t = *x;
	*x = *y;
	*y = t;

	return;
}
*/

void bubble_sort(io_element v[], int dim)
{
	int i = 0;
	int ordinato = 0;

	while (dim>1 && !ordinato)
	{
		ordinato = 1;
		for (i = 0; i < dim - 1; i++)
		{
			if (compareIoElement(v[i], v[i + 1]) < 0)  //v[i] < v[i+1]
			{
				scambia(&v[i], &v[i + 1]);
				ordinato = 0;
			}
		}

		dim--;
	}

	//scambi nel caso peggiore => O(dim^2/2)
	//scambi nel caso migliore => dim-1
}
//=================================================================================

//============== PROTOTIPI FUNZIONI INSERT_SORT ===================================
void ins_ord(io_element v[], int pos) 
{
	int i = pos - 1;
	io_element x = v[pos];

	while (i >= 0 && compareIoElement(x, v[i]) < 0)
	{
		v[i + 1] = v[i];
		i--;
	}

	v[i + 1] = x;
}

void insert_sort(io_element v[], int dim) 
{
	int k;
	for (k = 1; k<dim; k++)
	{
		ins_ord(v, k);
	}
}
//=================================================================================

//================ PROTOTIPI FUNZIONI MERGE_SORT ==================================
void merge(io_element v[], int i1, int i2, int fine, io_element vout[]) 
{
	//i1 -> first
	//i2 -> mid
	//fine -> last

	int i = i1, j = i2, k = i1;

	while (i <= i2 - 1 && j <= fine)
	{
		if (compareIoElement(v[i], v[j]) < 0)
		{
			vout[k] = v[i++];
		}
		else
		{
			vout[k] = v[j++];
		}

		k++;
	}

	while (i <= i2 - 1)
	{
		vout[k] = v[i++];
		k++;
	}

	while (j <= fine)
	{
		vout[k] = v[j++];
		k++;
	}

	for (i = i1; i <= fine; i++)
	{
		v[i] = vout[i];
	}
}

void merge_sort(io_element v[], int first, int last, io_element vout[]) 
{
	/*  --- LA CHIAMO IN QUESTO MODO ---
		void ordina(io_element * v, int dim)
		{
			Ordine * temp = (io_element*) malloc(sizeof(io_element) * dim);
			mergeSort(v, 0, dim-1, temp);
			free(temp);
		}
	*/

	int mid;

	if (first<last)
	{
		mid = (last + first) / 2;
		merge_sort(v, first, mid, vout);
		merge_sort(v, mid + 1, last, vout);
		merge(v, first, mid + 1, last, vout);
	}
}
//=================================================================================

//========================== FUNZIONI NAIVE_SORT ==================================
/*
void scambia(io_element *x, io_element *y)
{
	io_element t;

	t = *x;
	*x = *y;
	*y = t;

	return;
}
*/

void quick_sort_ric(io_element a[], int iniz, int fine)
{
	int i, j, ipivot;
	io_element pivot;

	if (iniz<fine)
	{
		i = iniz;
		j = fine;

		ipivot = fine;
		pivot = a[ipivot];

		do
		{
			while (i<j && compareIoElement(a[i], a[ipivot]) <= 0)
			{
				i++;
			}

			while (j>i && compareIoElement(a[i], a[ipivot]) >= 0)
			{
				j++;
			}
		} while (i<j);

		if (i != ipivot && compareIoElement(a[i], a[ipivot]) != 0)
		{
			scambia(&a[i], &a[ipivot]);
			ipivot = i;
		}

		if (iniz < ipivot - 1)
		{
			quick_sort_ric(a, iniz, ipivot - 1);
		}

		if (ipivot + 1 < fine)
		{
			quick_sort_ric(a, ipivot + 1, fine);
		}
	}
}

void quick_sort(io_element a[], int dim) 
{
	quick_sort_ric(a, 0, dim - 1);
}
//=================================================================================