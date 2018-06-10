#include"element.h"

//================== FUNZIONI TIPI UTILI ================================
int compareData(Data d1, Data d2) 
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

int compareTime(Time t1, Time t2)
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

//================== FUNZIONI FUNZIONI IO_ELEMENT ================================
int compareIoStruct(io_struct e1, io_struct e2) 
{
	//TODO
	int result;

	//comparazione intero, la prima comparazione � fuori da un if(){}
	result = e1.intero - e2.intero;

	//comparazione reali (NON HA MOLTO SENSO)
	float temp;
	if (result == 0)
	{
		temp = e1.intero - e2.intero;
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

	//comparazione stringhe
	if (result == 0)
	{
		result = strcmp(e1.stringa, e2.stringa);
	}

	//comparazione Data
	if (result == 0)
	{
		result = compareData(e1.data, e2.data);
	}

	//comparazione Time
	if (result == 0)
	{
		result = compareTime(e1.time, e2.time);
	}

	return result;
}

//================ FUNZIONI FUNZIONI LIST_ELEMENT ================================
int compareListStruct(list_struct le1, list_struct le2)
{
	int result;

	//comparazione intero, la prima comparazione � fuori da un if(){}
	result = le1.intero - le2.intero;

	//comparazione reali (NON HA MOLTO SENSO)
	float temp;
	if (result == 0) 
	{
		temp = le1.intero - le2.intero;
		if (temp == 0) 
		{
			result = 0;
		}
		else if (temp > 0) 
		{
			result = 1;
		}
		else if(temp < 0)
		{
			result = -1;
		}
	}

	//comparazione stringhe
	if (result == 0)
	{
		result = strcmp(le1.stringa, le2.stringa);
	}

	//comparazione Data
	if (result == 0)
	{
		result = compareData(le1.data, le2.data);
	}

	//comparazione Time
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
	printf("%d %f %s %d/%d/%d %d:%d:%d", le.intero, le.reale, le.stringa, le.data.giorno, le.data.mese, le.data.anno, le.time.ore, le.time.minuti, le.time.secondi);
}
