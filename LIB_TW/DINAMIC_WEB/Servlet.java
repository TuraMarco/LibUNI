//	_______________
//	| CONCORRENZA |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	Il metodo service() viene chiamato ad ogni HTTP Request (e quindi
//	ad ogni chiamata di doGet() e doPost()) e può essere invocato da 
//	numerosi client in modo concorrente è quindi necessario gestire 
//	le sezioni critiche (a completo carico del programmatore dell’applicazione Web):
//	> Uso di blocchi synchronized
//	> Semafori
//	> Mutex 
	
//	_______________
//	|   REQUEST   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Gli oggetti di tipo Request rappresentano la chiamataal server effettuata dal client
//	contiene le info di richiesta e i parametri di ingresso alla servlet recuperabili con la funzione:
//		String param = request.getParameter("paramName");
//	Altre metodi importanti per accedere al URL sono
//		String getContextPath() ---> restituisce info sulla parte di URL che tratta il contesto della WebApp
//		String getQueryString() ---> restituisce la stringa di query
//		String getPathInfo() ---> per ottenere il path 
//		String getPathTranslated() ---> per ottenere informazioni sul path nella forma risolta 
//	Altre metodi importanti per accedere al HEADER sono
//		String getHeader(String headerName) ---> ritorna il valore di un header specifico
//		Enumeration getHeaders(String name) --->  restituisce tutti i valori dell’header individuato da name sotto forma di enumerazione di stringhe
//		Enumeration getHeaderNames() ---> elenco dei nomi di tutti gli header presenti nella richiesta 
//		int getIntHeader(name) ---> valore di un header convertito in intero 
//		long getDateHeader(name) ---> valore della parte Date di header, convertito in long 
// 	Altre metodi importanti per accedere al HEADER sono
//		InputStream getInputStream() ---> consente di leggere il body della richiesta (ad esempiodati di post) 
//	Altre metodi importanti per AUTENTICAZIONE, SICUREZZA ed COOKIE
//		String getRemoteUser() ---> nome di user se la servlet ha accesso autenticato, null altrimenti 
//		String getAuthType() ---> nome dello schema di autenticazione usato per proteggere la servlet
//		boolean isUserInRole(String role) ---> restituisce true se l’utente è associato al ruolo specificato
//		Cookie[] getCookies() ---> restituisce un array di oggetti cookie che il client ha inviato alla request (IMPORTANTE)
//	Posso anche estrarre un InputStream per poter leggere il body:
//
// 			BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream()));
// 			System.out.println("Contenuto del body del pacchetto: ");
// 			while ((String line = in.readLine()) != null)
//			{
// 				System.out.println(line);
// 			}

//	_______________
//	|   RESPONSE  |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	Response rappresentano leinformazioni restituite al client in risposta ad una Request
//	e contiene:
//	  > Status Line ---> status code (200, 400, 500) e status phrase (page not found)
//	  > Header ---> header della risposta HTTP
//	  > Body ---> il contenuto testuale come pagine HTML
//	Possiede metodi come:
//	  > Indicare il content type (tipicamente text/html) (IMPORTANTE) ---> void setContentType(String contentType)
//    > Ottenere uno stream per scrivere il contenuto da restituire in formato testuale (IMPORTANTE) ---> PrintWriter getWriter()
//	  > Ottenere un OutputStream per scrivere il contenuto da restituire in formato binaria (IMPORTANTE) ---> ServletOutputStream getOuputStream()
//    > Specificare lo status code della risposta (200, 404, ...) ---> void setStatus (int statusCode) 
//	  > Inviare Errori ---> void sendError(int sc)
//						`-> void sendError(int code, String message)
//    > Specificare gli header ---> [imposto header arbitrario] void setHeader(String headerName, String headerValue)
//								|-> [imposto la data] void setDateHeader(String name, long millisecs)
//								`-> [imposta un header con un valore intero (evita la conversione intero-stringa)] void setIntHeader(String name, int headerValue)								
//    > Gestire i Cookie ---> void addCookie(Cookie cookie)
//    > Impostare i Redirect ---> void sendRedirect(String location)

//	_______________
//	|   CONTEXT   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	Ogni WebApp esegue in un suo Context specifico accessibbile attraverso un istanza di ServletContext
// 	e richiamabile con il metodo:
// 		ServletContext getServletContext()
// 	l'oggetto servlet context è condiviso tra tutti gli utenti, le richieste e le servlet facenti parte della WebApp. 
// 	Consente  di recuperare risorse statiche come immagini o media attraverso il metodo:
// 		InputStream	getResourceAsStream(String path) 
// 	Permette di accedere ai parametri di inizializzazione definiti nel file web.xml con il tag <context-param>
//	con il metodo:
//		String getInitParam(String paramName)
//	Infine permette di gestire gli attributi di contesto che svolgono il ruolo di variabili globali alla WebApp e sono 
//	settabili ed accessibili rispettivamente con i seguenti metodi:
//		void setAttribute(String name, Object object)  ---> Associo l'oggetto "object" all'attributo definito dalla stringa "name" 
//		Object getAttribute(String name) ---> recupero un riferimento all'attributo definito dalla stringa "name"
//	L'interfaccia context espone inoltre altri metodi utili per la gestione degli attributi come:
//		Enumeration getAttributeNames() ---> ritorna i nomi di tutti gli attributi
//		void removeAttribute(String name) ---> elimina l'attributo specificato

//	_______________
//	|    COOKIE   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	Il cookie è un’unità di informazione che Web server deposita sul Web browser lato cliente e sono astratti 
//	nelle WebApp servlet con la classe "Cookie" vengono cceduti e creati con i seguenti metodi della requestr e response:
//		Cookie[] getCookies() ---> chiamato sulla request ottiene un riferimento ad un Array di oggetti Cookie
//		void addCookie(Cookie cookie) ---> chiamato sulla response permette di aggiungere un istanza di Cookie alla response
//	Gli oggetti Cookie vengono istanziate con un costruttore che accetta 2 stringhe (nomeCookie e valoreCookie)
//	Essendo pericoloso l'impostazione di valori sensibili nei cookie vengono usualmente sfruttati come supporto dell'oggetto Session
//	per immagazzinare il SessionID

//	_______________
//	|   SESSION   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	La sessione Web è un’entità gestita dal Web container con scope interno alla comunicazione tra client e server, 
//	è condiviso quindi fra tutte le richieste provenienti dallo stesso client.
//	Viene identificato in modo univoco da un SessionID (tipicamente salvata in un cookie per garantire il binding Session/Client) 
//  e può essere recuperato chiamando sull'oggetto HttpServletRequest il metodo:
//		HttpSession getSession(boolean createNew)
//	il boolean specifica se si deve recuperare una sessione aperta o la si deve creare (nell caso sia TRUE e la sessione 
//	esista gia ritorna la sessione esistente).
//	Una volta ottenuto un oggetto Sessione è possibile salvarvi dentro e manipolare attributi in modo similare ai Context Attribute
//	con i metodi:
//		void setAttribute(String name, Object object)  ---> Associo l'oggetto "object" all'attributo definito dalla stringa "name" 
//		Object getAttribute(String name) ---> recupero un riferimento all'attributo definito dalla stringa "name"
//		Enumeration getAttributeNames() ---> ritorna i nomi di tutti gli attributi
//		void removeAttribute(String name) ---> elimina l'attributo specificato
//	Vi sono inoltre i seguenti metodi di utilità da usare sull'oggetto Session:
// 		String getID() ---> restituisce l’ID di una sessione 
// 		boolean isNew() ---> dice se la sessione è nuova 
// 		void invalidate() ---> permette di invalidare (distruggere) una sessione
// 		long getCreationTime() ---> dice da quanto tempo è attiva la sessione (in millisecondi) 
// 		long getCreationTime() ---> dice da quanto tempo è attiva la sessione (in millisecondi) 

//	__________________________
//	|   REDIRECT & FORWARD   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	Nel caso si voglia  forzare la ridirezione ad una pagina è possibile 
// 	usare uno dei codici di stato compresi tra 300 e 399, in particolare:
//		301 ---> Moved Permanently
//  Questo risultato è ottenibile o invocando il metodo
//		public void sendRedirect(String url)
//	oppure settando sugli header della response
//		response.setStatus(response.SC_MOVED_PERMANENTLY);
//		response.setHeader("Location", "http://....");
//	Un altro comportamento che si potrebbe voler implementare è quello dell'inclusione
//	di risorse di qualunque tipo, per fare ciò ci si avvale dell'oggetto RequestDispatcher
//		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/inServlet");
//		dispatcher.include(request, response);
//	Mentre per quanto riguarda il forward, tenendo a mente che la risposta è di competenza 
//	dell'ultima servlet della catena di inoltri e se viene aperto un canale di output da una 
//	precedente servlet si otterra un IllegalStateException.
//		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/inServlet");
//		dispatcher.forward(request, response);

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HomeServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
		
	/*
	 * Inizializza la servlet, vine chiamato dal web container una sola volta all'inizio
	 * */
	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		//TODO
		//	Qui si inizializza l'istanza, ad esempio è possibile creare la connessione con il DB
		//	Vengono inoltre richiamati i parametri definiti nel file web.xml con il tag <init-param>
		//	dopo aver definito una variabile interna:
		//		
		//		private String title;
		//
		//	viene chiamato il metodo di config per popolare la variabile, andando a prendere il valore in web.xml
		//
		//		title = config.getInitParameter("title");
	}
	
	/*
	 *  effettua il dispatch delle richieste ai metodi doGet, doPost, a seconda del metodo HTTP usato nella request
	 * */
	public void service(HttpServletRequest request, HttpServletResponse response) 
	{
		//TODO 
		//	Qui posso integrare una politica di dispatcing delle richieste alternativa al semplice doGet o doPost,
		//	ad esempio potrei ridirigere la gestione delle richieste secondo un parametro della request:
		//
		//		int reqId = Integer.parseInt(request.getParameter("reqID");
		//		switch(reqId)
		//		{
		//			case 1: handleReq1(request, response); break;
		//			case 2: handleReq2(request, response); break;
		//			default : handleReqUnknown(request, response);
		//		}
	}

	/*
	 * Risponde ad una richiesta del tipo GET
	 * */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	{
		//TODO 
		//	Qui posso integrare la politica di gestione delle richieste di tipo GET,
		//	da ricordare che l'eventuale gestione di elementi che possono causare exception
		//	deve essere incapsulata in un TRY/CATCH o in alternativa provocare un THROWS del metodo
	}

	/*
	 * Risponde ad una richiesta del tipo POST
	 * */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	{
		//TODO 
		//	Qui posso integrare la politica di gestione delle richieste di tipo POST,
		//	da ricordare che l'eventuale gestione di elementi che possono causare exception
		//	deve essere incapsulata in un TRY/CATCH o in alternativa provocare un THROWS del metodo 
	}
	
	/*
	 * Risponde ad una richiesta del tipo PUT
	 * */
	public void doPut(HttpServletRequest request, HttpServletResponse response)
	{
		//TODO 
		//	Qui posso integrare la politica di gestione delle richieste di tipo PUT,
		//	da ricordare che l'eventuale gestione di elementi che possono causare exception
		//	deve essere incapsulata in un TRY/CATCH o in alternativa provocare un THROWS del metodo 
	}
	
	/*
	 * Risponde ad una richiesta del tipo DELETE
	 * */
	public void doDelete(HttpServletRequest request, HttpServletResponse response)
	{
		//TODO 
		//	Qui posso integrare la politica di gestione delle richieste di tipo DELETE,
		//	da ricordare che l'eventuale gestione di elementi che possono causare exception
		//	deve essere incapsulata in un TRY/CATCH o in alternativa provocare un THROWS del metodo 
	}
}

//	____________________
//	|   METODI UTILI   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

//METODO PER INVIARE UN FILE XML, SI USA ASSIEME AD AJAX
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
{	
		resp.setHeader("Content-Type","application/xml");
		
		String nomecitta = req.getParameter("citta");
		String file = "/WEB-INF/resources/"+nomecitta+".xml";
		
		// classe URLConnection utile per reperire il file xml rispetto al contesto della Servlet
		URL url = null;
	    URLConnection urlConn = null;
	    PrintWriter out = null;
	    BufferedInputStream buf = null;
	    try {
	    	out = resp.getWriter();
	        url = getServletContext().getResource(file);

	        urlConn = url.openConnection();
	        urlConn.connect();
	    	buf = new BufferedInputStream(urlConn.getInputStream());
	    	int readBytes = 0;
	    	while ((readBytes = buf.read()) != -1)
	    		out.write(readBytes);
	    }
	    catch (Exception e) {
	    	if (out != null){
	    		// documento xml con le sole informaizoni base
	    		out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
	    		out.write("<citta nome=\""+nomecitta+"\">\n");
	    		out.write("</citta>\n");
	    	}
	    }
	    finally {
	    	if (out != null){
	    		out.close();
	    	}
	    	if (buf != null){
	    		buf.close();
	    	}
	    }
		
	}
