<!--
    _____________________
	|   SCRIPTING-TAG   |
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Le pagine jsp sono un susseguirsi di tag HTML e tag speciali che il web conteiner nella fase 
    di intermpretazione sostituisce con testo coerente, ricreando l'effetto di avere pagine HTML
    dinamicamente definite.
    I TAG speciali sono di 4 tipi:
        <%! %>   ->   Dichiarazione 
        <%= %>   ->   Espressione
        <% %>    ->   Scriptlet
        <%@ %>   ->   Direttive
    è anche possibile scrivere i tag con una notazione XML-oriented:
        <jsp:declaration>declaration</jsp:declaration>  ->   Dichiarazione 
        <jsp:expression>expression</jsp: expression>    ->   Espressione
        <jsp:scriptlet>java_code</jsp:scriptlet>        ->   Scriptlet
        <jsp:directive.dir_type dir_attribute />        ->   Direttive

    _____________________
	|   DICHIARAZIONI   |
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Si usa per dichiarare variabili e metodi che possono poi essere referenziuati in ogni altro 
    punto del codice jsp, nel caso si dichiarino metodi questi diventano metodi della server 
    una volta conclusa la traduzione della jsp.
    La sintassi da adottare è quella tipica del java
 
    ___________________
	|   ESPRESSIONI   |
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Si usano per valutare espressioni del java, il risultato di cio che vine inserito dentro viene 
    convertito in stringa e va a sostituire il TAG nella pagina HTML finale.
    La sintassi è anche qui quella standard di java con la sola eccezione del terminatore ';' che 
    deve essere omesso
        <div><%= new Date() %></div>
    verra tradotto in 
        <div> Tue Feb 20 11:23:02 2010 </div>

    _________________
	|   SCRIPTLET   |
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Questo tipo di TAG è usato per aggiungere frammenti di sintassi java alla jsp, tipicamente usato 
    per inserire logica di controllo del flusso di esecuzione della pagina, è importante che il flusso di
    tutti gli scriplet della pagina definisca un blocco logico coerente e completo
        <% if (userIsLogged) { %>
            <h1>Benvenuto Sig. <%=name%></h1>
        <% } else { %>
            <h1>Per accedere al sito devi fare il login</h1>
        <% } %>
    
    _________________
	|   DIRETTIVE   |
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Comandi JSP valutati a tempo di compilazione, le piu importanti sono:
    ~   page: permette di vare diverse cose tra cui definire il modello di esecuzione, 
            dichiarare pagine di errore o importare package java.
    ~   include: permette di includere un altro documento in quello presente
    ~   taglib: carica una libreria di customTag creata da terzi per estendere 
            le funzionalità di JSP (ad esempio JNDI)
    Questo genere di TAG non producono alcun output visibile.
        <%@ page info="Esempio di direttive" %>
        <%@ page language="java" import="java.net.*" %>
        <%@ page import="java.util.List, java.util.ArrayList" %>
        <%@ include file="myHeaderFile.html" %> 
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> //NON LE USIAMO       
    La direttiva page necessita di un ulteriore approfondimento per via della moltitudine 
    di direttive che può assegnare.
        <%@ page
            [ language="java" ]                                     // specifica il linguaggio usato
            [ extends="package.class" ]                             // estende la servlet                         
            [ import="{package.class | package.*}, ..." ]           // importa classi
            [ session="true | false" ]                              // gestisce la sessione
            [ buffer="none | 8kb | sizekb" ]                        // gestisce il buffer
            [ autoFlush="true | false" ]                            // gestisce il flush
            [ isThreadSafe="true | false" ]                         // gestisce la politica dei thread
            [ info="text" ]                                         // gestisce info generiche [Può essere letto con il metodo "Servlet.getServletInfo()"]
            [ errorPage="relativeURL" ]                             // specifica dove trovar la pagina di errore
            [ contentType="mimeType [ ;charset=characterSet ]"|     // specifica contentType e charset
            "text/html ; charset=ISO-8859-1" ]
            [ isErrorPage="true | false" ]                          // dichiara se è una pagina di errore o no
        %>

    _______________________
	|   BUILT-IN OBJECT   |
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Le specifiche JSP definiscono 8 oggetti built-in che non serve istanziare
    che rappresentano riferimenti ai corrispondenti oggetti java presenti nella 
    tecnologie servlet.
    page        ->  javax.servlet.jsp.HttpJspPage
    config      ->  javax.servlet.ServletConfig
    request     ->  javax.servlet.http.HttpServletRequest
    response    ->  javax.servlet.http.HttpServletResponse
    out         ->  javax.servlet.jsp.JspWriter
    session     ->  javax.servlet.http.HttpSession
    application ->  javax.servlet.ServletContext
    pageContext ->  javax.servlet.jsp.PageContext
    exception   ->  java.lang.Throwable

    L'oggetto PAGE rappreenta l'istanza corrente della servlet, 
    è usato quindi per accedere a tutti i metodi definiti nella servlet come:
        getServletInfo(): restituisce info sulla servlet come l'autore, la versione o il copyright

    L'oggetto CONFIG contiene i parametri di configurazione ed inizializzazione della servlet
    utile principalmente per estrarre gli initParameter con:
        getInitParameterName(): restituisce tutti i nomi dei parametri di inizializzazione
        getInitParameter(name): restituisce il valore del parametro passato per nome

    L'oggetto REQUEST rappresenta la richiesta alla pagina JSP ed è lo stesso parametro passato al
    metodo service() della servlet.
    Consente l'accesso a tutte le informazioni relative alla richiesta HTTP e ai metodi dell'oggetto request
    (vedi servlet.java)
    Alcuni metodi possono essere:
        String getParameter(String parName): restituisce valore di un parametro individuato per nome
        Enumeration getParameterNames(): restituisce l’elenco dei nomi dei parametri
        String getHeader(String name): restituisce il valore di un header individuato per nome sotto forma di stringa
        Enumeration getHeaderNames(): elenco nomi di tutti gli header presenti nella richiesta
        Cookie[] getCookies(): restituisce un array di oggetti cookie che client ha inviato alla request 

    L'oggetto RESPONSE è legato all'I/O della pagina JSP è anche questo lo stesso parametro passato al metodo 
    service() delle servlet.
    Rappresenta la risposta che viene restituita al client e consente di inserire nella risposta diverse
    informazioni:
    >   content type ed encoding
    >   eventuali header di risposta
    >   URL Rewriting
    >   i cookie
    permette di accedere a tutti i metodi dell'oggetto response delle servlet (vedi servlet.java)
    Alcuni metodi possono essere:
        public void setHeader(String headerName, String headerValue): imposta header
        public void setDateHeader(String name, long millisecs): imposta data
        addHeader(), addDateHeader(), addIntHeader(): aggiungono nuova occorrenza di un dato header
        setContentType(): determina content-type
        addCookie(): consente di gestire i cookie nella risposta
        getWriter(): restituisce uno stream di caratteri (un’istanza di PrintWriter)
        getOuputStream(): restituisce uno stream di byte (un’istanza di ServletOutputStream) 

    L'oggetto OUT rappresenta lo stream di caratteri di output della pagina ed espone i seguenti metodi:
        print(String s): Scrive una stringa sullo stream di output
        isAutoFlush(): dice se output buffer è stato impostato in modalità autoFlush o meno
        getBufferSize(): restituisce dimensioni del buffer
        getRemaining(): indica quanti byte liberi ci sono nel buffer
        clearBuffer(): ripulisce il buffer
        flush(): forza l'emissione del contenuto del buffer
        close(): fa flush e chiude stream 

    L'oggetto SESSION fornisce info sul contesto di esecuzione della JSP in termini di sessione utente
    espone i meodi dell'oggetto session delle servlet (vedi servlet.jsp)
    Alcuni metodi sono:
        setAttribute(String attributeName, Object attributeValue): inserisce un nuovo attributo di sessione
        setMaxInactiveInterval(int second): setta il tempo di inattività massimo   
        getID(): restituisce ID di una sessione
        isNew(): dice se sessione è nuova
        invalidate(): permette di invalidare (distruggere) una sessione
        getCreationTime(): ci dice da quanto tempo è attiva la sessione (in ms)
        getLastAccessedTime(): ci dice quando è stata utilizzata l’ultima volta (in ms)

    L'oggetto APPLICATION fornisce informazione sul contesto di esecuzione delle JSP con scope di visibilità
    comune a tutti gli utenti, viene mappato su un istanza di ServletContext.
    Rappresenta la Web application a cui JSP appartiene inoltre consente di interagire con l’ambiente di esecuzione:
    >   fornisce la versione di JSP Container
    >   garantisce l’accesso a risorse server-side
    >   permette accesso ai parametri di inizializzazione relativi all’applicazione
    >   consente di gestire gli attributi di un'applicazione

    L'oggetto PAGE_CONTEXT fornisce informazioni sul contesto di esecuzione della pagina JSP rappresentandone 
    l'insieme degli oggetti impliciti, permette inoltre il trasferimento del controllo ad altre pagine (utile piu per i customTag)

    L'oggetto EXCEPTION è connesso alla gestione degli errori, rappresenta l'eccezione non gestita da 
    alcun blocco catch, è disponibile automaticamente solo nelle pagine segnate come 
    ErrorPage (dichiarate con l'attributo): <%@ page isErrorPage="true" %>
    Tra i metodi che offre vi è:
        printStackTrace(OutputStream out): stampa un messaggio di errore
    
    ______________
	|   AZIONI   |
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Le azioni sono comandi JSP tipicamente preposti all'interazione con altre pagine JSP, Servlet o JavaBean, 
    vengono tipicamente espresso usando sintassi XML.
    Le AZIONI definite sono:
        useBean: istanzia JavaBean e gli associa un identificativo
            <jsp:useBean id="myBean" class="it.unibo.deis.my.HelloBean" scope="page|request|session|application"/>
        setProperty: imposta valore della property indicata per nome
            <jsp:setProperty name="myBean" property="nameProp" param="value"/>
        getProperty: ritorna property indicata come oggetto
            <jsp:getProperty name="myBean" property="nameProp"/>
        include: include nella JSP contenuto generato dinamicamente da un’altra pagina locale
             <jsp:include page="localURL" flush="true" />
        forward: cede controllo ad un’altra JSP o servlet
             <jsp:forward page="localURL" />
        plugin: genera contenuto per scaricare plug-in Java se necessario (NON LO USIAMO)

    Per quanto riguarda il FORWARD, consente il trasferimento del controllo dalla pagina JSP corrente 
    ad un altra pagina sul server locale, come si puo vedere sopra l'attributo "page" definisce l'URL della 
    pagina a cui trasferire il controllo.
    Il forward causa un trasferimento della request trasparente al client che riceverà la response.
    E' possibile generare dinamicamente l'attributo page con l'aiuto del TAG <%= %>.
    Gli oggetti Request, Response e Session della pagina d'arrivo sono gli stessi della pagina chiamante,
    viene solo istanziato un nuovo oggetto PageContext.
    Come nel caso delle Servlet il forward è possilbile solo se non è stato emesso alcun output dalla pagina chiamante.
    E' anche possibile esprimere parametri nel body cosi che questi siano visibili al chiamato come nel esempio seguente:
        <jsp:forward page="localURL">
            <jsp:param name="parName1“ value="parValue1"/>
            ...
            <jsp:param name="parNameN“ value="parValueN"/>
        </jsp:forward>

    Per quanto riguarda l'INCLUDE, consente di includere il contenuto generato dinamicamente da un'altra pagina locale 
    all'interno dell'output della pagina corrente
    E' caratterizzato dalla presenza di 2 parametri:
        page    -> definisce la pagina locale da includere
        flush   -> dichiara se prima dell'inclusione debba essere fatto un flush del buffer
    Anche qui gli oggetti Session, Request e Response sono gli stessi, viene solo istanziato un nuovo PageContext.
    E' anche qui possibile esprimere parametri nel body cosi che questi siano visibili al chiamato come nel esempio seguente:
        <jsp:include page="localURL">
            <jsp:param name="parName1“ value="parValue1"/>
            ...
            <jsp:param name="parNameN“ value="parValueN"/>
        </jsp:include>

    Infine si descrive il MODEL1 ossia l'unione delle JSP con i JAVABEAN, per istanziare quest'ultimi si usa l'azione:
        <jsp:useBean id="myBean" class="it.unibo.deis.my.HelloBean" scope="page|request|session|application"/>
    che permette di istanziare un bean.
    Il tag useBean accetta 3 argomenti principali:
        id      ->  il nome dell'istanza del bean
        class   ->  la classe del bean da istanziare
        scope   ->  lo scope della istanza del bean.
                        |-  page:   questo è il default, l'istanza sopravvive fino al forward o al completamento della pagina.
                        |-  request:    come page ma sopravvive a forward ed include.
                        |-  session:    richiesta corrente e tutte quelle dello stesso client.
                        |_  application:    richiesta corrente ed ogni altra richiesta che fa parte dell'applicazione.
    Per accedere alle istanze del bean in lettura o scrittura si usano rispetivamente le azioni:
        <jsp:getProperty name="myBean" property="nameProp"/>
        <jsp:setProperty name="myBean" property="nameProp" param="value"/>
    Dove l'argomento "name" è il nome dell'istanza del bean, "propery" il nome della proprietà a cui accedere associata a quell'istanza,
    e nel caso della sola setProperty, "param" esprime il valore da padssare alla proprietà.
    Da notare che le azioni descritte non permettono l'accesso a proprietà indicizzate, per cui in quello specifico caso è possibile usare
    il TAG-EXPRESSION:
        <%= bean.getIndexProperty(index) %>
-->