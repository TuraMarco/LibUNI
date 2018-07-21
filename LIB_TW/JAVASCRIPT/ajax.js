//	______________________
//	|   XMLHTTPREQUEST   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  AJAX è una libreria (ormai standard) per JS finalizzata a permettere interazioni asicrone con un server,
//  ossia senza che un aggiornamento parziale della pagina causi un ricaricamento complessivo.
//  Per ottenere un comportamento adeguato si è implementato un oggetto specifico "XMLHttpRequest".
//  L'oggetto JS effettua la richiesta HTTP ad un server web in modo indipendete dal browser, le richieste
//  possono essere di tipo GET o POST, comunque questa interazione non sostituisce l'URI della pagina e non provoca
//  un cambiamento della pagina stessa.
//  Per ottenere l'oggetto XMLHttpRequest tipicamente è necessario istanziarlo come un qualunque oggetto JS attraverso 
//  il suo costruttore:
var xhr = new XMLHttpRequest();
// ma essendoci problemi di retrocompatibilità è bene usare una funzione ad hoc che li risolva
function myGetXmlHttpRequest() 
{
    var xhr = false;
    var activeXoptions = new Array( "Microsoft.XmlHttp", "MSXML4.XmlHttp", "MSXML3.XmlHttp", "MSXML2.XmlHttp", "MSXML.XmlHttp" );
    // prima come oggetto nativo
    try 
    { 
        xhr = new XMLHttpRequest();
    }
    catch (e) { }

        // poi come oggetto activeX dal più al meno recente
        if (!xhr) 
        {
            var created = false;
            for (var i=0 ; i<activeXoptions.length && !created ; i++) 
            {
                try 
                {
                    xhr = new ActiveXObject( activeXoptions[i] );
                    created = true;
                }
                catch (e) { }
            }
        }
        return xhr;
   }

//  Una volta ottenuto l'oggetto si passa a leggerne le risorse, stato e risultato delle richieste 
//  vengono salvati dall'interprete JS all'interno dell'oggetto "xhr" durante l'esecuzione.
//  I parametri fondamentali sono:
//      readyState  --->    variabile di tipo intero che varia da 0 a 4, accedibile in sola lettura, rappresenta lo stato di avanzamento della richiesta AJAX.
//                              |- 0: uninitialized ---> "xhr" esiste ma non è ancora stato inizializzato.
//                              |- 1: open ---> è stato invocato il metodo .open() ma non il .send()
//                              |- 2: sent ---> il metodo .send() è stato eseguito è ha dato origine alla richiesta
//                              |- 3: recieving ---> - i dati in risposta cominciano ad essere letti
//                              |_ 4: sent ---> - l'operazione è stata completata (unico certamente supportato da tutti i browser)                                
//      onreadystatechange  --->    evento che viene invocato al cambio della variabile "readyState", (associare handler prima di invocare la send())
//      status  --->    valore intero corrispondente al codice HTTP dell'esito della richiesta, (unico esito se si ha un successo è 200)
//      statusText  --->    descrizione testuale associata al codice HTTP dell'esito della richiesta
//      responseText    --->    rappresentazione testuale dei dati ricevuti (disponibile solo ad interazione ultimata, "readyState==4")
//      responseXML     --->    rappresentazione XML dei dati ricevuti, navigabile con JS (disponibile anche'essa ad interazione ultimata, potrebbe essere "null" 
//                              se i dati restituiti non sono un documento XML ben formato)

//  Per inizializzare la richiesta da formulare al server si usa la funzione open(), la sintassi del comando prevede 5 attributi di cui 3 opzionali,
//      open (method, uri [,async][,user][,password]);
//          |- method: stringa e assume il valore "get" o "post"
//          |- uri: stringa che identifica la risorsa da ottenere (URL assoluto o relativo)
//          |- async: valore booleano opzionale che deve essere impostato come true per indicare al metodo che la richiesta da effettuare è di tipo asincron
//          |_ user, password: username e password opzionali

//  Per impostare gli header HTTP della richiesta da inviare si usa il metodo:
//      setRequestHeader(nomeHeader, valoreHeader);
//  viene invocato una volta per ogniu header da aggiungere, nelle richieste GET gli header sono opzionali, in quelle POST sono invece obbligatori
//  per impostare la codifica utilizzata.
//  E' comunque sempre importante impostare l'header:
setRequestHeader(connection, close);

//  Per inviare la richiesta al server si usa il metodo:
send(body)
//  nel caso si sia inizializzata la XMLHttpRequest con il flag async a true, la chiamata a questo metodo non è bloccante, prende come parametro 
//  una stringa che costituisce il body della richiesta HTTP.

//GET
var xhr = new XMLHttpRequest();
xhr.open("GET", "pagina.html?p1=v1&p2=v2", true);
xhr.setRequestHeader("connection", "close");
xhr.send(null);

//POST
var xhr = new XMLHttpRequest();
xhr.open("POST", "pagina.html", true );
xhttp.setReGsoquestHeader("Content-type", "application/x-www-form-urlencoded");
xhr.setRequestHeader("connection", "close");
xhr.send("p1=v1&p2=v2");

//  Per accedere agli header della response HTTP è possibile usare 2 funzioni che sono
getResponseHeader("headerName"); //ritorna l'header specificato
getAllResponseHeaders(); //ritorna una collezione
//  queste 2 funzioni sono utilizzabili solo nella funzione di callback, e comunque solo nei momenti in cui la variabile readyState ha valore 3 o 4
//  quindi solo a richiesta conclusa o se supportata dal browser nel mom ento in cui inizia ad arrivare la risposta anche se non conclusa.

//  Per interrompere una chiamata asincrona si usa il metodo:
abort();
//  questo metodo non accetta parametri e fa si che la trasmissione dei dati sia istantaneamente terminata, il modo piu intelligente per sfruttarlo è
//  attraverso una chiamata schedulata in modo che funga da time out nel caso la chiamata AJAX si protragga per troppo tempo.
setTimeOut(xhr.abort(),timeOut);

//	________________
//	|   CALLBACK   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  La fiunzione di callback permette di gestire le richieste AJAX, va assrgnata all'evento "onreadystatechange", si divide in 4 parti
//  1- Leggo lo stato di avanzamento della richiesta attraverso la variabile "readyState"
//  2- Verifica il successo o fallimento della richiesta con la variabile "status"
//  3- Accede agli header di risposta  (parziali se readystate == 3, completi se readystate == 4)
//  4- Legge il contenuto della risposta (se e solo se readyState == 4)
var xhr = myGetXmlHttpRequest(); // ottengo la variabile XMLHttpRequest

var textHolder = new Object();
textHolder.testo = "La risposta del server è: ";

xhr.onreadystatechange = function() 
{
    if ( xhr.readyState == 4 && xhr.status == 200 ) 
    {
    /*
    * anche se la funzione è assegnata a una proprietà di xhr,
    * dal suo interno non è possibile riferirsi a xhr con this
    * perché la funzione sarà richiamata in modo asincrono dall’interprete
    */
    }
};
//  E' possibile usare argomenti nella funzione di Callback nel seguente modo
function callbackWithArg(arg1, arg2){};
xhr.onreadystatechange = function() 
{
    callbackWithArg(arg1, arg2);
};


// funzione getElementById senza problemi di compatibilità tra browser
function myGetElementById(idElemento) 
{
    // elemento da restituire
    var elemento;
    // se esiste il metodo getElementById questo if sarà
    // diverso da false, null o undefined
    // e sarà quindi considerato valido, come un true
    if ( document.getElementById )
    {
        elemento = document.getElementById(idElemento);
    }
    else
    {
        // altrimenti è necessario usare un vecchio sistema
        elemento = document.all[idElemento];
    }
    // restituzione elemento
    return elemento;
   }

//	____________
//	|   JSON   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯
//  JSON è l'acronimo di Java Script Object Notation, è un formato per lo scambio 
//  di dati più efficente e sintetico rispetto ad XML, e comunque human readable.
//  Si basa sulla notazione usata per descrivere gli oggetti JavaScript, piu precisamente
//  Object Literal ed Array Literal.
var oggettoJSON =
[
    {   // oggetto 1
        "NameVar1.1": "ValVar1.1",
        "NameVar1.2": "ValVar1.2",
        "NameArray1.1": ["ValArray1.1.1","ValArray1.1.2","ValArray1.1.3"]
    },
    {   // oggetto 2
        "NameVar2.1": "ValVar2.1",
        "NameVar2.2": "ValVar2.2",
        "NameArray2.1": ["ValArray2.1.1","ValArray2.1.2","ValArray2.1.3"]
    }
];
//  Al fine di convertire una stringa JSON in un oggetto JS, il linguaggio mette
//  nativamente a disposizione la funzione "eval()", che accetta come argomento
//  una stringa JSON tra parentesi tonde, e ritorna un istanza dell'oggetto JS equivalente.
var o = eval('('+oggettoJSON+')');
//  Comunque l'uso di eval() presenta non pochi rischi, poiche stringhe passate come parametro
//  potrebbero contenere codice malevolo, per questo motivo esistono parser appositi, implementati
//  in specifiche librerie JS.
//  Il più diffuso parser è json.js, che espone l'oggetto JSON con 2 metodi:
JSON.parse(strJSON);  // converte una stringa JSON in oggetto JS in modo safe
JSON.stringify(objJSON); //converte un oggetto JS in una stringa JSON
//  E' importante ricordare che in seguito alla conversione da oggetto a stringa è necessario usare
//  la funzione:
encodeURIComponent()
//  per convertire la stringa in un formato usabile in una richeista HTTP

//	_______________
//	|   ESEMPIO   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

//ESEMPIO DI mANIPOLAZIONE DI UN FILE XML
function leggiContenuto(item, nomeNodo) {
	return item.getElementsByTagName(nomeNodo).item(0).firstChild.nodeValue;
}

function mostraAffitti(xml, min, max, output){

	// Otteniamo la lista degli item "casa"
	var houses = xml.getElementsByTagName("casa");

	// Predisponiamo una struttura dati in cui memorrizzare le informazioni di interesse
	var itemNodes = new Array();

	// ciclo di lettura degli elementi
	for (  var i = 0, count = 0; i < houses.length; i++  ) {
		var prezzo = leggiContenuto(houses[i], "prezzo");
		if( prezzo>=eval(min) && prezzo<=eval(max) ){
			itemNodes[count] = new Object();
			itemNodes[count].indirizzo = leggiContenuto(houses[i],"indirizzo");
			itemNodes[count].prezzo = prezzo
			count++;
		}			
	}// for ( houses )
	
	// apertura e chiusura della lista sono esterne al ciclo for 
	// in modo che eseguano anche in assenza di "casa"
	var risultato = "<br />elenco case:<br />";
	risultato += "<ul>";

	for( var j = 0; j < itemNodes.length; j++ ) {
		risultato += '<li><strong>';
		risultato += itemNodes[j].indirizzo +'</strong>: ';
		risultato += itemNodes[j].prezzo;
		risultato += '</li>';
	};

	// chiudiamo la lista creata
	risultato += "</ul>";

     // inseriamo l'html nella pagina
	output.innerHTML = risultato;

}// mostraAffitti()


/*
 * Funzione di callback
 */
function cittaCallback( theXhr, nomeCitta, arrayCitta ) {

	// verifica dello stato
	if ( theXhr.readyState === 2 ) {
    	// non faccio niente
    	// theElement.innerHTML = "Richiesta inviata...";
	}// if 2
	else if ( theXhr.readyState === 3 ) {
    	// non faccio niente
		// theElement.innerHTML = "Ricezione della risposta...";
	}// if 3
	else if ( theXhr.readyState === 4 ) {
		// verifica della risposta da parte del server
	        if ( theXhr.status === 200 ) {
	        	// operazione avvenuta con successo	
		        if ( theXhr.responseXML ) {
		        	arrayCitta[nomeCitta] = theXhr.responseXML;
				}
				else {
			    	// non faccio niente
				}
	        }
	        else {
	        	// errore di caricamento
	        	// non faccio niente nemmeno qui
	        }
	}// if 4
} // cittaCallback();

/*
 * Usa tecniche AJAX attraverso la XmlHttpRequest fornita in theXhr
 */
function caricaCittaAJAX(theUri, nomeCitta, arrayCitta, theXhr) {
    
	// impostazione controllo e stato della richiesta
	theXhr.onreadystatechange = function() { cittaCallback(theXhr, nomeCitta, arrayCitta); };

	// impostazione richiesta asincrona in GET del file specificato
	try {
		theXhr.open("get", theUri, true);
	}
	catch(e) {
		// Exceptions are raised when trying to access cross-domain URIs 
		alert(e);
	}

	// rimozione dell'header "connection" come "keep alive"
	theXhr.setRequestHeader("connection", "close");

	// invio richiesta
	theXhr.send(null);

} // caricaCittaAJAX()

//FUNZIONE DA ASSOCIARE A CIO CHE SCATENA LA CHIAMATA AJAX
function caricaCitta(uri, nomeCitta, arrayCitta) {

	// assegnazione oggetto XMLHttpRequest
	var xhr = myGetXmlHttpRequest();

	if ( xhr ) 
		caricaCittaAJAX(uri, nomeCitta, arrayCitta, xhr); 

}// caricaCitta()

