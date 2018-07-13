//	____________________
//	|   INTRODUZIONE   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  JQuery è una libreria JavaScript (sviluppata da terzi) pensata appositamente per semplificare la vita del programmatore Web,
//  semplifica e velocizza:
//  >   l'attraversamento del DOM di una pagine HTML,
//  >   la sua animazione,
//  >   la gestione di eventi, e
//  >   le interazioni Ajax 
//  mediante una "easy-to-use" API che funziona per una moltitudine di Web browser fornendo la compatibilità cross-browser che 
//  spesso JavaScript fatica a trovare.

//	_________________
//	|   OGGETTO $   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  In JQuery tutto ruota attorno all'oggetto/funzione $, abbreviazione o alias di JQuery.
//  L'oggetto $  è l'operatore principe di selezione, in particolare si fa quasi tutto attraverso i parametri della funzione $(),
//  la caratteristica piu utile di JQuery è il suo motore di selezione:
//      $('nome_tag') ----> restituisce un oggetto JQuery contenente tutti i tag di tipo nome_tag
//      $('.nome_class') ----> restituisce un oggetto JQuery contenente tutti gli oggetti del DOM appartenenti alla classe nome_class
//      $('#nome_id') ----> restituisce un oggetto JQuery contenente tutti gli oggetti del DOM con id nome_id
//      $('[nome_attr=val_attr]') ----> restituisce un oggetto JQuery contenente tutti gli oggetti del DOM aventi l'attributo nome_attr che vale val_attr
//  Vedi JQuery.pdf per ulteriori selettori.
//
//  JQuery offre innumerevoli metodi e proprietà per accedere al DOM
$("#menu li").size(); // dimensione di una collezione
$("#menu li").lenght; // come sopra ma con sintassi array, più veloce

$("#menu li").get(0); // ottenere elementi da una lista

$("#menu li").eq(0).html(); // ottenre l'HTML
$("#menu li").get(0).innerHTML; // come sopra ma con JS nativo

$("a#mioLink").attr("href"); // restituisce il valore di un attributo, href
$("a#mioLink").attr("href","http://www.html.it"); // imposta il valore di un attributo, href
$("a#mioLink").attr("href",function () { return "http://www.html.it" }); // imposta il valore di un attributo in base alla funzione, href
$("#menu li a").removeAttr("target"); // rimuove un attributo

$("p").text("Nuovo testo"); // inserire testo nel corpo di un tag
$("p").html("Nuovo testo con <strong>HTML</strong>"); // inserire HTML nel corpo di un tag

$("a").css("color"); // restituisce il valore di una direttiva CSS, colore esadecimale del primo elemento link
$("a").css("color","#FF0000"); //imposta il valore di una direttiva CSS, colore dei link
$("a").css({ //imposta il valore di diverse direttiva CSS contemporaneamente
    "color" : "#FF0000", //imposta il colore
    "display" : "block" // imposta la visualizzazione
});