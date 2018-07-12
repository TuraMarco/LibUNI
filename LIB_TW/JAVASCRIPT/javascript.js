
//	_________________
//	|   VARIABILI   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Le variabili sono dichiarate attraverso la parola chiave "var" ed inizialmente non hanno alcun tipo, 
//  sono "undefined", non "null" che è simile ma non uguale una volta associate ad un valore literal
//  assumono dinamicamente il tipo adeguato, JS ha 3 tipi fondamentali:
//  >   number:     numero rappresentato in formato floating point a 8 byte, senza distinzione tra interi e reali, 
//                  oltre a tutti i valori possibili vi è NaN, per risultati di operazioni non ammesse, ed il valore "infinite"
//  >   boolean:    ammette i valori literal "true" e "false"
//  >   string:     ammette stringhe di caratteri (PIU' O MENO!!!)

//	_______________
//	|   OGGETTI   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Gli oggetti sono tipi composti che contengono un certo numero di proprietà (o attributi).
//  Ogni proprietà ha un nome ed un valore, e si accede alla proprietà con l'operatore '.'(punto),
//  cosa importante è che le proprietà non sono definite a priori ma possono essere aggiunte dinamicamente.
//  Gli oggetti vengono creati con l'operatore "new" seguendo la sintassi:
//      var o = new Object()
//  Da notare che Object non è una classe ma un costruttore, le classi non esistono.
//  Un oggetto creato con il costruttore Object() è vuoto all'inizio, può essere popolato con proprietà nel seguente modo
//      o.x = 7;
//      o.y = 8;
//      o.tot = o.x + o.y;
//  Posso esprimesre un oggetto come costante attraverso degli Object Literal con la seguente sintassi:
//      var o = {x:7, y:8, tot:15} //non accetta espressioni

//	_____________
//	|   ARRAY   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯
//  GLi array sono tipi composti i cui elementi sono accessibili mediante un indice numerico che parte da 0, 
//  non hanno una dimensione prefissata ed espongono attributi e metodi.
//  Possono essere istanziati con il comando "new" o usando il literal:
//      var varname = [val,val2, … ,valn]
//  Gli array possono contenere variabili di valore eterogeneo.
//  Gli oggetti in realtà sono array associativi, invece di associare gli elementi che contengono a indici numerici 
//  usano label testuali.

//	________________
//	|   STRINGHE   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  In JS le stringhe sono sequenze di caratteri arbitrari in formato UNICODE a 16 bit immutabili, come in java.
//  E' possibile esprimere costanti stringa con il literal "stringa" oppure 'stringa', posso concatenare 2 stringhe 
//  con l'operatore '+' e posso compararle con gli operatori: <, >, <=, >=, ==, !=, ===.
//  E' possibile inoltre invocare metodi su di una stringa o accedere ai suoi attributi come ad esempio: 
//      var s = "CIAO";
//      var n = s.length;
//      var t = s.charAt(1)
//  Per quanto abbiano molte caratteristiche in comune con gli oggetti non lo sono, esiste pero un wrapper String 
//  che è un oggetto, di cui vien fatto il boxing automatico.

//	______________
//	|   REG_EX   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  JavaScript gestisce nativamente il supporto alle regular expression, che sono un dato nativo del linguaggio,
//  come per gli altri tipi di dato, esistono le costanti RegExp Literal definibili con la sintassi:
//      /pattern/modificatore
//  oppure può essere creata con il costruttore RegExp().
//  I modificatori possono essere:
//      i	case insensitive
//      g	global match (find all matches rather than stopping after the first match)
//      m	Perform multiline matching
//  I pattern invece:
//      [abc]	Find any character between the brackets
//      [^abc]	Find any character NOT between the brackets
//      [0-9]	Find any character between the brackets (any digit)
//      [^0-9]	Find any character NOT between the brackets (any non-digit)
//      (x|y)	Find any of the alternatives specified
//  La sintassi è molto più ricca sono presenti anche metacaratteri e quantificatori (https://www.w3schools.com/jsref/jsref_obj_regexp.asp).
//  Per sfruttare una RegEx si usa la seguente sintassi:
//      /pattern/modificatore.exec("stringa");

//	________________
//	|   FUNZIONI   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Una funzione è un feammento che viene definito una volta ed utilizato piu volte in seguito,
//  amette parametri privi di tipo e restituisce un valore privo di tipo.
//  Le funzioni vengono definite con la parola chiave "function" ed è possibile associarla ad una variabile.
//  E' inoltre possibile definirla attraversa