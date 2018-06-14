#include"element.h"



















//////////////////////////////////////
//		FUNZIONI DI LIBRERIA		//
//////////////////////////////////////

//================== FUNZIONI FUNZIONI IO_ELEMENT ================================
int compareData(Data d1, Data d2) // d1 successiva d2 <=> result > 0
{
	int result;
	result = d1.anno - d2.anno;

	if (result == 0)
	{
		result = d1.mese - d2.mese;
	}
													
	if (result == 0)
	{
		result = d1.giorno - d2.giorno;
	}

	return result;
}

void showData(Data d)
{
	printf("%d/%d/%d", d.giorno, d.mese, d.anno);
}

int compareTime(Time t1, Time t2) // t1 successiva t2 <=> result > 0
{
	int result;
	result = t1.ore - t2.ore;

	if (result == 0)
	{
		result = t1.minuti - t2.minuti;
	}

	if (result == 0)
	{
		result = t1.secondi - t2.secondi;
	}

	return result;
}

void showTime(Time t)
{
	printf("%d:%d:%d", t.ore, t.minuti, t.secondi);
}

int compareIoStruct(io_struct e1, io_struct e2)   //e1 > e2 <=> result > 0
{
	//TODO 
	// Dsa editare in base al compito

	int result;

	//comparazione intero (e1.intero > e2.intero <=> result > 0) 
	//la prima comparazione � fuori da un if(){}
	result = e1.intero - e2.intero; 

	//comparazione reali (e1.reale > e2.reale <=> result > 0)
	float temp;
	if (result == 0)
	{
		temp = e1.reale - e2.reale;
		if (temp == 0)
		{
			result = 0;
		}
		else if (temp > 0)
		{
			result = 1;
		}
		else if (temp < 0)
		{
			result = -1;
		}
	}

	//comparazione stringhe (e1.stringa > e2.stringa <=> result > 0)
	if (result == 0)
	{
		result = strcmp(e1.stringa, e2.stringa);
	}

	//comparazione Data (e1.data successiva e2.data <=> result > 0)
	if (result == 0)
	{
		result = compareData(e1.data, e2.data);
	}

	//comparazione Time (e1.time successiva e2.time <=> result > 0)
	if (result == 0)
	{
		result = compareTime(e1.time, e2.time);
	}

	return result;
}

void showIoStruct(io_struct e) 
{
	//TODO 
	// Da editare in base al compito
	printf("%d %f %s ", e.intero, e.reale, e.stringa);
	showData(e.data);
	printf(" ");
	showTime(e.time);
}

void showIoStructArray(io_struct * array, int dim)
{
	int i = 0;

	printf("{\n");
	for (i ; i<dim ; i++)
	{
		printf("\t");
		showIoStruct(array[i]);
		printf("\n");
	}
	printf("}\n");
}

//================ FUNZIONI FUNZIONI LIST_ELEMENT ================================
int compareListStruct(list_struct le1, list_struct le2)
{
	//TODO 
	// Dsa editare in base al compito

	int result;

	//comparazione intero  (le1.intero > le2.intero <=> result > 0)  
	//la prima comparazione � fuori da un if(){}
	result = le1.intero - le2.intero;

	//comparazione reali  (le1.reale > le2.reale <=> result > 0) 
	float temp;
	if (result == 0)
	{
		temp = le1.reale - le2.reale;
		if (temp == 0)
		{
			result = 0;
		}
		else if (temp > 0)
		{
			result = 1;
		}
		else if (temp < 0)
		{
			result = -1;
		}
	}

	//comparazione stringhe (le1.stringa > le2.stringa <=> result > 0)
	if (result == 0)
	{
		result = strcmp(le1.stringa, le2.stringa);
	}

	//comparazione Data (le1.data successiva le2.data <=> result > 0)
	if (result == 0)
	{
		result = compareData(le1.data, le2.data);
	}

	//comparazione Time (le1.time successiva le2.time <=> result > 0)
	if (result == 0)
	{
		result = compareTime(le1.time, le2.time);
	}

	return result;
}

BOOL equalsListStruct(list_struct le1, list_struct le2)
{
	if (compareListStruct(le1, le2) == 0)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

void showListStruct(list_struct le)
{
	//TODO 
	// Da editare in base al compito
	printf("%d %f %s ", le.intero, le.reale, le.stringa);
	showData(le.data);
	printf(" ");
	showTime(le.time);
}

void showAllListStruct(list_struct le)
{
	//chiamo la funzione di list.h
	showList(le);
}
