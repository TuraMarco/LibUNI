
//	_________________
//	|   VARIABILI   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Le variabili sono dichiarate attraverso la parola chiave "var" ed inizialmente non hanno alcun tipo, 
//  sono "undefined", non "null" che è simile ma non uguale una volta associate ad un valore literal
//  assumono dinamicamente il tipo adeguato, JS ha 3 tipi fondamentali:
//      number ----> numero rappresentato in formato floating point a 8 byte, senza distinzione tra interi e reali, 
//                   oltre a tutti i valori possibili vi è NaN, per risultati di operazioni non ammesse, ed il valore "infinite".
//      boolean ---> ammette i valori literal "true" e "false".
//      string ----> ammette stringhe di caratteri (PIU' O MENO!!!).

//	_______________
//	|   OGGETTI   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Gli oggetti sono tipi composti che contengono un certo numero di proprietà (o attributi).
//  Ogni proprietà ha un nome ed un valore, e si accede alla proprietà con l'operatore '.'(punto),
//  cosa importante è che le proprietà non sono definite a priori ma possono essere aggiunte dinamicamente.
//  Gli oggetti vengono creati con l'operatore "new" seguendo la sintassi:
    var o = new Object()
//  Da notare che Object non è una classe ma un costruttore, le classi non esistono.
//  Un oggetto creato con il costruttore Object() è vuoto all'inizio, può essere popolato con proprietà nel seguente modo
o.x = 7;
o.y = 8;
o.tot = o.x + o.y;
//  Posso esprimesre un oggetto come costante attraverso degli Object Literal con la seguente sintassi:
var o = {x:7, y:8, tot:15} //non accetta espressioni

//	_____________
//	|   ARRAY   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯
//  GLi array sono tipi composti i cui elementi sono accessibili mediante un indice numerico che parte da 0, 
//  non hanno una dimensione prefissata ed espongono attributi e metodi.
//  Possono essere istanziati con il comando "new" o usando il literal:
var varname = [val,val2, valn]
//  Gli array possono contenere variabili di valore eterogeneo.
//  Gli oggetti in realtà sono array associativi, invece di associare gli elementi che contengono a indici numerici 
//  usano label testuali.

//	________________
//	|   STRINGHE   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  In JS le stringhe sono sequenze di caratteri arbitrari in formato UNICODE a 16 bit immutabili, come in java.
//  E' possibile esprimere costanti stringa con il literal "stringa" oppure 'stringa', posso concatenare 2 stringhe 
//  con l'operatore '+' e posso compararle con gli operatori: <, >, <=, >=, ==, !=.
//  E' possibile inoltre invocare metodi su di una stringa o accedere ai suoi attributi come ad esempio: 
var s = "CIAO";
var n = s.length;
var t = s.charAt(1)
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
//      i ----> case insensitive
//      g ----> global match (find all matches rather than stopping after the first match)
//      m ----> Perform multiline matching
//  I pattern invece:
//      [abc] ----> Find any character between the brackets
//      [^abc] ---> Find any character NOT between the brackets
//      [0-9] ----> Find any character between the brackets (any digit)
//      [^0-9] ---> Find any character NOT between the brackets (any non-digit)
//      (x|y) ----> Find any of the alternatives specified
//  La sintassi è molto più ricca sono presenti anche metacaratteri e quantificatori (https://www.w3schools.com/jsref/jsref_obj_regexp.asp).
//  Per sfruttare una RegEx si usa la seguente sintassi:
/pattern/modificatore.exec("stringa");

//	________________
//	|   FUNZIONI   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Una funzione è un feammento che viene definito una volta ed utilizato piu volte in seguito,
//  amette parametri privi di tipo e restituisce un valore privo di tipo.
//  Le funzioni vengono definite con la parola chiave "function" ed è possibile associarla ad una variabile.
//  E' inoltre possibile definirla attraversa una Function Literal con la seguente sintassi:
//      var sum = function(x,y) { return x+y; }
//  Quando una funzione viene associata ad una proprietà di un oggetto prende il nome di metodo,
//  in questo caso all'interno della funzione si può utilizzare la parola chiave "this" per accedere all'oggetto
//  di cui la funzione è una proprietà.
var o = new Object();
o.x = 7;
o.y = 8;
o.tot = function() { return this.x + this.y; }
//
//  Una specifica ed utile funzione è il costruttore, che ha come scopo quello di costruire un oggetto invocandola con "new",
//  riceve l'oggetto appena creato e può aggiungere proprietà e metodi, anche qui l'oggetto da costruire è accessibile con "this".
function Rectangle(w, h)
{
    this.w = w;
    this.h = h;
    this.area = function() { return this.w * this.h; }
    this.perimeter = function() { return 2*(this.w + this.h);}
}
//
//  E'presente anche un oggetto globale che espone funzioni predefinite, sempre dispoibiliche sono;
eval(expr)    // valuta la stringa expr (che contiene un'espressione Javascript)
isFinite(number) // dice se il numero è finito
isNaN(testValue) // dice se il valore è NaN
parseInt(str [radix]) // converte la stringa str in un intero (in base radix - opzionale)
parseFloat(str) // converte la stringa str in un numero

//	____________________
//	|   INFO BROWSER   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
navigator.appName       // Nome del browser (es. Microsoft Internet Explorer)
navigator.appVersion    // Versione del Browser (es. 5.0 (Windows))
navigator.platform      // Piattaforma per cui il browser è stato compilato (es. Win32)

//	____________________
//	|   INFO MONITOR   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
screen.width        // Risoluzione orizzontale
screen.height       // Risoluzione verticale

//	________________________
//	|   OGGETTO DOCUMENT   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Oggetto che astrae il concetto di DOM, esponendo 4 collezioni che rispettivamente sono
//      anchors[] ---> riferimenti
//      forms[] -----> form
//      images[] ----> immagini
//      links[] -----> link
//  Posso accedere agli elementi di queste collezioni con:
document.links[n];
document.links["nomelink"];
document.nomelink;
//  Inoltre espone alcuni utili metodi come:
document.getElementById() // restituisce un riferimento al primo oggetto della pagina avente l’id specificato come argomento
document.write() // scrive un pezzo di testo nel documento
document.writeln() // come write() ma aggiunge un a capo
// e proprietà:
document.bgcolor // colore di sfondo
document.fgcolor // colore di primo piano
document.lastModified // data e ora di ultima modifica
document.cookie // tutti i cookies associati al document rappresentati da una stringa di coppie: nome-valore
document.title // titolo del documento
document.URL // url del documento

//	____________________
//	|   OGGETTO FORM   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Un oggetto FORM può essere recuperato attraverso la collection forms[] dell'oggetto document nei seguenti modi:
document.nomeForm;
document.forms[n];
document.forms["nomeForm"];
//  A sua volta l'oggetto form espone una collection chiamata elements[] che referenzia gli oggetti element che la compongono,
//  questi elementi possono essere ricavati con i seguenti metodi:
document.nomeForm.nomeElemento;
document.forms[n].elements[m];
document.forms["nomeForm"].elements["nomeElem"];
//  inoltre ogni elemento ha una proprietà form che permette di accedere al form che lo contiene ed altre 
//  proprietà per ogni attributo che la definisce: id, name (IMPORTANTE), value (IMPORTANTE), type, className, ecc...
//  L'oggetto FORM espone sue proprietà:
document.nomeForm.action // riflette l’attributo action
document.nomeForm.elements // vettore contenente gli elementi della form
document.nomeForm.length // numero di elementi nella form
document.nomeForm.method // riflette l’attributo method
document.nomeForm.name // nome del form
document.nomeForm.target // riflette l’attributo target
//  metodi
document.nomeForm.reset() // resetta il form
document.nomeForm.submit() // esegue il submit
//  ed eventi
document.nomeForm.onreset // quando il form viene resettato
document.nomeForm.onsubmit // Squando viene eseguito il submit del form

//	_______________________
//	|   OGGETTO ELEMENT   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Ogni elemento che può entrare a far parte di una form viene rappresentato da un oggetto JavaScript:
//      Text ----> <input type="text">
//      Checkbox ----> <input type="checkbox">
//      Radio ----> <input type="radio">
//      Button ----> <input type="button"> o <button>
//      Hidden ----> <input type="hidden">
//      File ----> <input type="file">
//      Password ----> <input type="password">
//      Textarea ----> <textarea>
//      Submit ----> <input type="submit">
//      Reset ----> <input type="reset"> 
//  Ogniuno di questo elementi espone delle proprietà:
//      form ----> riferimento al form che contiene il controllo
//      name ----> nome del controllo
//      type ----> typo del controllo
//      value ----> valore dell’attributo value
//      disabled ----> disabilitazione/abilitazione del controllo
//  dei metordi:
//      blur() ----> toglie il focus al controllo
//      focus() ----> dà il focus al controllo
//      click() ----> simula il click del mouse sul controllo
//  e degli eventi
//      onblur ----> quando il controllo perde il focus
//      onfocus ----> quando il controllo prende il focus
//      onclick ----> quando l’utente clicca sul controllo
//
//  Per quanto riguarda elementi di tipo TEXT o PASSWORD sono esposte altre proprietà:
//      defaultValue ----> valore di default
//      Disabled ----> disabilitazione / abilitazione del campo
//      maxLength ----> numero massimo di caratteri
//      readOnly ----> sola lettura / lettura e scrittura
//      size ----> dimensione del controllo
//  e metodi:
//      select() ----> seleziona una parte di testo
//  
//  Per quanto riguarda invece CHECKBOX e RADIO vengono esposte delle proprietà:
//      checked ----> dice se il box e spuntato
//      defaultChecked ----> impostazione di default

//	________________________
//	|   VALIDAZIONI FORM   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

//Funzione per controllare il range di un valore numerico
function qty_check(item, min, max)
{
    returnVal = false;
    if ((parseInt(item.value) < min)||(parseInt(item.value) > max))
    {
        alert(item.name+"deve essere fra "+min+" e "+max);
    }
    else
    {
        return true;
    }   
}

// funzione per portare in UpperCase il testo di 2 text
function upperCase()
{
    var val = document.myForm.firstName.value;
    document.myForm.firstName.value = val.toUpperCase();
    val = document.myForm.lastName.value;
    document.myForm.lastName.value = val.toUpperCase();
}

// funzione di validazione di un intera form
function validateAndSubmit(theForm)
{
    if (qty_check(theform.quantità,0,999))
    { 
        alert("Ordine accettato"); return true; 
    }
    else
    { 
        alert("Ordine rifiutato"); return false; 
    }
}
