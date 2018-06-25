package it.unibo.tw.servlets;
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
//	|    REQUEST  |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Contiene le info di richiesta e i parametri di ingresso alla servlet
//	recuperabili con la funzione:
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
//	Altre metodi importanti per AUTENTICAZIONE, SICUREZZA ed COOKIE
//		String getRemoteUser() ---> nome di user se la servlet ha accesso autenticato, null altrimenti 
//		String getAuthType() ---> nome dello schema di autenticazione usato per proteggere la servlet
//		boolean isUserInRole(String role) ---> restituisce true se l’utente è associato al ruolo specificato
//		Cookie[] getCookies() ---> restituisce un array di oggetti cookie che il client ha inviato alla request (IMPORTANTE) 

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
	public void init() 
	{
		
	}
	
	/*
	 * Risponde ad una richiesta del tipo GET
	 * */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("CI SONO!!!!!");
		int number = Integer.parseInt(request.getParameter("numero"));
		response.setContentType("text/html");
		System.out.println("Numero: " + number);
		
		try 
		{
			PrintWriter out = response.getWriter();
			
			out.println("<html>");
			out.println("<head><title>Home Response</title></head>");
			out.println("<body>Numero: " + number);
			out.println("</html>");
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}

	/*
	 * Risponde ad una richiesta del tipo POST
	 * */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	{
		//TODO 
	}
	
	/*
	 * Risponde ad una richiesta del tipo PUT
	 * */
	public void doPut(HttpServletRequest request, HttpServletResponse response)
	{
		//TODO 
	}
	
	/*
	 * Risponde ad una richiesta del tipo DELETE
	 * */
	public void doDelete(HttpServletRequest request, HttpServletResponse response)
	{
		//TODO 
	}
}
