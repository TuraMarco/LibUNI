#include "esame.h"

/*=================================================*/
//						ARRAY                      //
/*=================================================*/

//LEGGI UNO ALLA VOLTA  E METTI IN UN ARRAY =============================================================================================================================
io_element leggiUno(FILE * fp)
{
	io_element result;
	BOOL letturaCorretta = TRUE;

	//leggi intero
	if (scanf(fp, "%d", &(result.intero)) != 1 && letturaCorretta == TRUE)
	{
		letturaCorretta = FALSE;
	}

	//leggi float
	if (scanf(fp, "%f", &(result.reale)) != 1 && letturaCorretta == TRUE)
	{
		letturaCorretta = FALSE;
	}

	//leggi stringa
	if (scanf(fp, "%s", &(result.stringa)) != 1 && letturaCorretta == TRUE)
	{
		letturaCorretta = FALSE;
	}

	//leggi stringa iterativamente, da usare solo se la stringa è alla fine della linea del file (DA NOTARE CHE NON SETTA IL BOOLEAN)
	if (letturaCorretta == TRUE)
	{
		int i = 0;
		char ch;

		//LEGGI ===============================================
		ch = fgetc(fp); // elimino lo spazio di separazione (COMMENTARE SE NON CI SONO SPAZI ALL'INIZIO DELLA STRINGA)

		do
		{
			ch = fgetc(fp);
			if (ch != '\n' || ch != EOF || i < MAX_STRING_LENGHT - 1)
			{
				result.stringa[i] = ch;
				i++;
			}
		} while (ch != '\n' || ch != EOF || i < MAX_STRING_LENGHT - 1);

		result.stringa[i] = '\0';
	}

	//lettura Date
	if (fscanf(fp, "%d/%d/%d", &(result.data.giorno), &(result.data.mese), &(result.data.anno)) != 3 && letturaCorretta == TRUE)
	{
		letturaCorretta = FALSE;
	}

	//lettura Time
	if (fscanf(fp, "%d:%d:%d", &(result.time.ore), &(result.time.minuti), &(result.time.secondi)) != 3 && letturaCorretta == TRUE)
	{
		letturaCorretta = FALSE;
	}
	
	//STRUTTURA DI ERRORE ==================================
	if (letturaCorretta == FALSE)
	{
		result.intero = 0;
		result.reale = 0;
		strcpy(result.stringa, "");
		return result;
	}
	else
	{
		return result;
	}

}

BOOL isLetturaCorretta(io_element element)
{
	//da modificare in funzione di quello che è la struttura base nel caso di errori di lettura
	if (element.intero != 0 && element.reale != 0 && sizeof(element.stringa) != 0)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

io_element * leggiTutti(char * fileName, int * dim)
{
	// ricordati di chiamarlo con "v = leggiTutte("file.txt", &dim);"

	FILE * fp;
	io_element * result;
	io_element temp;
	int count;
	*dim = 0;

	fp = fopen(fileName, "rt");
	if (fp != NULL)
	{
		count = 0;
		temp = leggiUno(fp);
		while (isLetturaCorretta(temp) == TRUE) //controllo del termine della lettura
		{
			count++;
			temp = leggiUno(fp);
		}

		rewind(fp);
		result = (io_element*)malloc(sizeof(io_element) * count);
		count = 0;

		temp = leggiUno(fp);
		while (isLetturaCorretta(temp) == TRUE) //controllo del termine della lettura
		{
			result[count] = temp;
			count++;
			temp = leggiUno(fp);
		}

		*dim = count;
		fclose(fp);
	}
	else
	{
		result = NULL;
		*dim = 0;
	}

	return result;
}

//LEGGI IN UNA VOLTA E METTI IN UN ARRAY ================================================================================================================================
io_element * leggiTuttiInsieme(char * fileName, int * dim) 
{
	FILE * fp;
	io_element * result;
	io_element temp;
	int count;
	BOOL letturaCorretto;

	*dim = 0;
	count = 0;
	letturaCorretto = TRUE;

	fp = fopen(fileName, "rt");
	if (fp != NULL) 
	{
		//CONTA LINEE =========================================
		while (letturaCorretto)
		{
			//LEGGI RIGA ================================================================================================================================================

			//leggi intero
			if (scanf(fp, "%d", &(temp.intero)) != 1 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//leggi float
			if (scanf(fp, "%f", &(temp.reale)) != 1 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//leggi stringa
			if (scanf(fp, "%s", &(temp.stringa)) != 1 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//leggi stringa iterativamente, da usare solo se la stringa è alla fine della linea del file (DA NOTARE CHE NON SETTA IL BOOLEAN)
			if (letturaCorretta == TRUE)
			{
				int i = 0;
				char ch;

				ch = fgetc(fp); // elimino lo spazio di separazione (COMMENTARE SE NON CI SONO SPAZI ALL'INIZIO DELLA STRINGA)

				do
				{
					ch = fgetc(fp);
					if (ch != '\n' || ch != EOF || i < MAX_STRING_LENGHT - 1)
					{
						temp.stringa[i] = ch;
						i++;
					}
				} while (ch != '\n' || ch != EOF || i < MAX_STRING_LENGHT - 1);

				temp.stringa[i] = '\0';
			}

			//lettura Date
			if (fscanf(fp, "%d/%d/%d", &(temp.data.giorno), &(temp.data.mese), &(temp.data.anno)) != 3 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//lettura Time
			if (fscanf(fp, "%d:%d:%d", &(temp.time.ore), &(temp.time.minuti), &(temp.time.secondi)) != 3 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}
			//===========================================================================================================================================================

			if (letturaCorretta)
			{
				*dim = *dim + 1;  //CONTATORE
			}
		}

		letturaCorretta = TRUE;
		rewind(fp);
		result = (Ordine *)malloc(sizeof(io_element) * *dim);

		//SALVA LINEE ========================================
		while (letturaCorretto) //conta le linee ben formate
		{
			//leggi intero
			if (scanf(fp, "%d", &(temp.intero)) != 1 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//leggi float
			if (scanf(fp, "%f", &(temp.reale)) != 1 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//leggi stringa
			if (scanf(fp, "%s", &(temp.stringa)) != 1 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//leggi stringa iterativamente, da usare solo se la stringa è alla fine della linea del file (DA NOTARE CHE NON SETTA IL BOOLEAN)
			if (letturaCorretta == TRUE)
			{
				int i = 0;
				char ch;

				ch = fgetc(fp); // elimino lo spazio di separazione (COMMENTARE SE NON CI SONO SPAZI ALL'INIZIO DELLA STRINGA)

				do
				{
					ch = fgetc(fp);
					if (ch != '\n' || ch != EOF || i < MAX_STRING_LENGHT - 1)
					{
						temp.stringa[i] = ch;
						i++;
					}
				} while (ch != '\n' || ch != EOF || i < MAX_STRING_LENGHT - 1);

				temp.stringa[i] = '\0';
			}

			//lettura Date
			if (fscanf(fp, "%d/%d/%d", &(temp.data.giorno), &(temp.data.mese), &(temp.data.anno)) != 3 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}

			//lettura Time
			if (fscanf(fp, "%d:%d:%d", &(temp.time.ore), &(temp.time.minuti), &(temp.time.secondi)) != 3 && letturaCorretta == TRUE)
			{
				letturaCorretta = FALSE;
			}
			//===========================================================================================================================================================

			if (letturaCorretta)
			{
				*dim = *dim + 1;
				result[i] = temp;
			}
			else 
			{
				//TODO io_element di defoult a causa di un errore
				temp.intero = 0;
				temp.reale = 0;
				strcpy(temp.stringa, "");
				*dim = *dim + 1;
				result[i] = temp;
			}
		}
	}
	else 
	{
		printf("Errore nell'apertura del file %s\n", fileName);
		result = NULL;
	}

	return result;
}

//STAMPA ARRAY ==========================================================================================================================================================
void stampaTutti(io_element * v, int dim)
{
	int i;
	for (i = 0; i<dim; i++)
	{
		//stampa intero
		printf("%d", v[i].intero);

		//stampa intero
		printf("%f", v[i].reale);

		//stampa intero
		printf("%s", v[i].stringa);

		//stampa Data
		printf("%d/%d/%d", v[i].data.giorno, v[i].data.mese, v[i].data.anno);

		//stampa Time
		printf("%d:%d:%d", v[i].time.ore, v[i].time.minuti, v[i].time.secondi);
	}
}

/*=================================================*/
//						LISTE                      //
/*=================================================*/