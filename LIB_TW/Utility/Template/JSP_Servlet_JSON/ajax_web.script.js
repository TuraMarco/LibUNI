function callback(theXhr, target) 
{
	if (theXhr.readyState === 2) 
	{
		// theElement.innerHTML = "Richiesta inviata...";
	} 
	else if (theXhr.readyState === 3) 
	{
		// theElement.innerHTML = "Ricezione della risposta...";
	} 
	else if (theXhr.readyState === 4) 
	{
		if (theXhr.status === 200) 
		{
			if (theXhr.responseText) 
			{
				//nel caso sia JSON
				var res = parsificaJSONArray(theXhr.responseText);
				target.innerHTML = res;

				// oppure

				if (target.children.length > 5) 
				{
					target.children[0].remove();
				}
				var child = document.createElement("li");
				child.innerText = JSON.parse(theXhr.responseText).message;
				target.appendChild(child);
			} 
			else 
			{
				// non faccio niente
			}
		} 
		else 
		{
			// errore di caricamento non faccio niente nemmeno qui
		}
	}
}

//AJAX GET
function eseguiAJAX(uri, target, xhr) 
{
	xhr.onreadystatechange = function()
	{
		callback(xhr, target);
	};

	// impostazione richiesta asincrona in GET del file specificato
	try 
	{
		xhr.open("get", uri, true);
	} 
	catch (e) 
	{
		// Eccezione scatenata nel caso di accesso ad un Cross-Domain URI
		alert(e);
	}

	// rimozione dell'header "connection" come "keep alive"
	xhr.setRequestHeader("connection", "close");

	// invio richiesta
	xhr.send(null);
}

//AJAX POST (NON NECESSARIA)
function eseguiAJAXPost(uri, body, target, xhr) 
{
	xhr.onreadystatechange = function() 
	{
		callback(xhr, target);
	};

	// impostazione richiesta asincrona in POST del file specificato
	try 
	{
		xhr.open("post", uri, true);
	} 
	catch (e) 
	{
		// Exceptions are raised when trying to access cross-domain URIs
		alert(e);
	}

	// rimozione dell'header "connection" come "keep alive" ed impostazione del content type
	xhr.setRequestHeader("connection", "close");
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

	// invio richiesta (es: body="fname=Henry&lname=Ford")
	xhr.send(body);
}

function esegui(uri, target) 
{
	var xhr = myGetXmlHttpRequest();
	if (xhr)
	{
		eseguiAJAX(uri, target, xhr);
	}	
}

function parsificaJSON(jsonText) 
{
	var something = JSON.parse(jsonText);
	var risultato = "<b>" + something.message + "</b>";
	return risultato;
}

//NON NECESSARIA
function eseguiPost(uri, body, target) 
{
	var xhr = myGetXmlHttpRequest();
	if (xhr)
	{
		eseguiAJAXPost(uri, body, target, xhr);
	}
}

function parsificaJSONArray(jsonText) {
	var something = JSON.parse(jsonText);
	var risultato = "";
	for (var i = 0; i < something.length; i++) {
		if (something[i] != null)
			risultato += "<li>" + something[i].message + "</li>";
	}
	return risultato;
}

function leggiContenutoNode(item, nomeNodo) {
	return item.getElementsByTagName(nomeNodo).item(0).firstChild.nodeValue;
};

/*
 * Funzione che genera una lista XHTML con gli item presi dal testo ricevuto
 * come argomento xml
 */
function parsificaXml(xml) {

	var items = xml.getElementsByTagName("item"),

	// Predisponiamo una struttura dati in cui memorizzare le informazioni di
	// interesse
	itemNodes = new Array(),

	// la variabile di ritorno, in questo esempio, e' testuale
	risultato = "";

	// ciclo di lettura degli elementi
	for (var a = 0, b = items.length; a < b; a++) {
		itemNodes[a] = new Object();
		itemNodes[a].title = leggiContenuto(items[a], "title");
		itemNodes[a].description = leggiContenuto(items[a], "description");
		itemNodes[a].link = leggiContenuto(items[a], "link");
	}// for ( items )

	risultato = "<ul>";

	for (var c = 0; c < itemNodes.length; c++) {
		risultato += '<li>' + itemNodes[c].title + '<br/>';
		risultato += itemNodes[c].description + "<br/>";
		risultato += '<a href="' + itemNodes[c].link+ '">approfondisci</a><br/></li>';
	}

	risultato += "</ul>";

	// restituzione dell'html da aggiungere alla pagina
	return risultato;
}
