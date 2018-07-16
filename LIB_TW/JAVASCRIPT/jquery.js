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

//COLLEZIONI
$("#menu li").size(); // dimensione di una collezione
$("#menu li").lenght; // come sopra ma con sintassi array, più veloce

//ELEMENTI
$("#menu li").get(0); // ottenere elementi da una lista

//HTML
$("#menu li").eq(0).html(); // ottenre l'HTML
$("#menu li").get(0).innerHTML; // come sopra ma con JS nativo

//ATTRIBUTO
$("a#mioLink").attr("href"); // restituisce il valore di un attributo, href
$("a#mioLink").attr("href","http://www.html.it"); // imposta il valore di un attributo, href
$("a#mioLink").attr("href",function () { return "http://www.html.it" }); // imposta il valore di un attributo in base alla funzione, href
$("#menu li a").removeAttr("target"); // rimuove un attributo

//CORPO DEI TAG
$("p").text("Nuovo testo"); // inserire testo nel corpo di un tag
$("p").html("Nuovo testo con <strong>HTML</strong>"); // inserire HTML nel corpo di un tag

//CSS
$("a").css("color"); // restituisce il valore di una direttiva CSS, colore esadecimale del primo elemento link
$("a").css("color","#FF0000"); //imposta il valore di una direttiva CSS, colore dei link
$("a").css({ //imposta il valore di diverse direttiva CSS contemporaneamente
    "color" : "#FF0000", //imposta il colore
    "display" : "block" // imposta la visualizzazione
});

//EVENTI
$("p").click(           // nome del evento da gestire, qui CLICK
    function () {       // si usa per un evento alla volta
        $(this).css("background-color", "red");
    }
)
$("p").on({             // "on" va bene per qualunque evento, accetta un oggetto composto dal binding tra eventi ed hendler
    mousenter: function () {
        $(this).css("background-color", "Green");
    },
    mouseleave: function () {
        $(this).css("background-color", "white");
    },
    click: function () {
        $(this).css("background-color", "red");
    }
})

//MODIFICA DEL DOM
$('body').append('<p id="roba">Nuovo Testo</p>');     //inserisce dentro il body
$('#roba').prepend('<p>Nuovo Testo Inserito Prima</p>');    //inserisce prima del tag con id="roba"
$('<li>ASD</li>').appendTo('#menu');    //inserisce il <li> all'interno della lista con id="menu"