function caricaDocumento()
{
	var url = "jsonservlet"; //servlet che deve tornare il JSON
	esegui(url, myGetElementByID("request"));
}

function caricaDocumentoAppend(form) 
{
	for (var i = 0; i < form.elements.length; i++) 
	{
		if (isBlank(form.elements[i]))
			return false;
	}
	
	var url = "appendservlet?nuovoPezzo=" + form.elements.myGetElementByID("inputarea").value;
	esegui(url, myGetElementByID("request")); //spedisco il nuovo pezzo alla servlet JsonServlet
	window.location.reload();
}

function eseguiModifiche(form){
	for (var i = 0; i < form.elements.length; i+=2){
		var url = "adminservlet?oldAutore=" + form.elements[i].name +
				"&oldPezzo=" + form.elements[i++].name +
				"&nuovoAutore=" + form.elements[i].value +
				"&nuovoPezzo=" + form.elements[i].value;
		esegui(url, myGetElementByID("request"));
	}
	window.location.reload();
}

function isBlank(myField) {
    // Check for non-blank field
    var result = false;
    if (myField.value!=null && myField.value.trim() == "") {
        alert("Please enter a value for the '" + myField.name + "' field.");
        myField.focus();
        result = true;
    }
    return result;
}


//NONNECESSARIE
function validateAjaxForm(form) {
	for (var i = 0; i < form.elements.length; i++) {
		if (isBlank(form.elements[i]))
			return;
	}
	// altri check
	var url = "ajaxservlet?param=...";
	// oppure
	var message = new Object();
	message.javaClass = "esame.beans.AjaxMessage";
	message.message = "ciao";
	var url2 = JSON.stringify(message);
	esegui(url, myGetElementById("response"));
}

function setListeners(table) {
    for (var i = 0; i < table.children.length; i++) {
        var tr = table.children[i];
        if (tr.tagName == "TR") {
            for (var j = 0; j < tr.children.length; j++) {
                var td = tr.children[j];
                if (td.tagName == "TD") {
                    td.addEventListener("click", new Function("show('" + td.innerText + "');"));
                }
            }
        }
    }
}
