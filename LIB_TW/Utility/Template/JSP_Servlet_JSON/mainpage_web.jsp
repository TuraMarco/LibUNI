<!-- Nel caso sia necessario usare il login, vedi template JSP_Servlet_Login -->
<jsp:include page="loginservlet"/>

<%-- uso della sessione --%>
<%@ page session="true"%>

<%-- import java --%>
<%@ page import="org.jabsorb.JSONSerializer"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat, java.text.DateFormat"%>
<%@ page import="bean.Documento, bean.Autore"%> <!-- bean usati nei JSON -->
<%@ page import="bean.LoginInfo"%>	<!-- Nel caso sia necessario usare il login, vedi template JSP_Servlet_Login -->

<%-- pagina per la gestione di errori --%>
<%@ page errorPage="errors/failure.jsp"%>

<%-- istanzio oggetto condiviso tra utenti con scope "application" --%>
<jsp:useBean id="applicationBean" class="bean.Documento" scope="application" />

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>MainPage USER</title>
		<link rel="stylesheet" href="styles/defoult.css" type="text/css" />
	</head>
	<body onload="caricaDocumento()">	<%-- Aggiorno la risorsa condivisa in caso di refresh --%>
		<div id="container">
		
			<%-- Lettura e conversione del JSON di request --%>
			<jsp:include page="/jsonservlet"></jsp:include>
			<%
				String jsonDocument = (String) request.getAttribute("jsonDocument");
				if (jsonDocument != null) 
				{
					JSONSerializer serializer = new JSONSerializer();
					try 
					{
						// inizializza i tipi serializzatori forniti di default 
						serializer.registerDefaultSerializers();
					} 
					catch (Exception e) 
					{
						System.out.println(e.getMessage());
						e.printStackTrace();
					}

					// ricevere un oggetto serializzato come parametro della richiesta
					applicationBean = (Documento) serializer.fromJSON(jsonDocument);
				}
			%>
		
		<%-- Stampa del contenuto della risorsa condivisa ottenuta via JSON --%>	
		<div id="body">
		<%
			for(Autore aut : applicationBean.getList()){
		%>
		<p><%=aut.getNome() %></p><br/>
		<p><%=aut.getPezzo() %></p><br/>
		<%
			}
		%>
		
		<%-- Append alla risorsa condivisa --%>
		<p>Inserisci qui il tuo nuovo pezzo!</p>
		<hr />
		<script src="scripts/forms.js" type="text/javascript"></script>
		<fieldset><legend>Form inserimento</legend>
		<form name="search" onSubmit="caricaDocumentoAppend(this)">
			<label for="nuovoPezzo">Scrivi qui il tuo nuovo pezzo</label><br/>
			<textarea id="inputarea" name="inputarea" placeholder="Scrivi qui il tuo nuovo pezzo..." rows="50" cols="50"> <br />
			<input type="submit" value="Append">
		</form>
		</fieldset>
		<hr />
		</div>
	</div>
</body>
</html>
 