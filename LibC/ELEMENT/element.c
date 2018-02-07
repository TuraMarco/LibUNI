#include"element.h"

//================== FUNZIONI FUNZIONI IO_ELEMENT ================================
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

int compareIoElement(io_element e1, io_element e2) 
{
	//TODO
	int result;

	//comparazione intero, la prima comparazione è fuori da un if(){}
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
int compareListElement(list_element le1, list_element le2)
{
	int result;

	//comparazione intero, la prima comparazione è fuori da un if(){}
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

BOOL equalsListElement(list_element le1, list_element le2)
{
	if (compareListElement(le1, le2) == 0) 
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

void showListElement(list_element le)
{
	printf("%d %f %s %d/%d/%d %d:%d:%d", le.intero, le.reale, le.stringa, le.data.giorno, le.data.mese, le.data.anno, le.time.ore, le.time.minuti, le.time.secondi);
}

//================ FUNZIONI VARIE ================================================
int readField(char buffer[], int dimBuffer, char separatore, FILE *f)
{
	int i = 0;
	char ch = fgetc(f);

	while (ch != separatore && ch != 10 && ch != EOF && i < dimBuffer - 1) 
	{
		buffer[i] = ch;
		i++;
		ch = fgetc(f);
	}

	buffer[i] = '\0';
	return ch;
}