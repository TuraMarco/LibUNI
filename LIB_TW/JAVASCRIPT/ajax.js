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
xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
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

xhr.onreadystatechange = function() {
 if ( xhr.readyState == 4 && xhr.status == 200 ) {
 /*
 * anche se la funzione è assegnata a una proprietà di xhr,
 * dal suo interno non è possibile riferirsi a xhr con this
 * perché la funzione sarà richiamata in modo asincrono dall’interprete
 */
 }
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
   