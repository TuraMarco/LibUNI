<jsp:include page="loginservlet" />

<%@ page session="true"%>
<%@ page language="java" import="java.net.*"%>
<%@ page import="java.util.List"%>
<%@ page import="bean.Autore, bean.Documento"%>
<%@ page import="bean.LoginInfo"%>
<%@ page errorPage="errors/failure.jsp"%>

<jsp:useBean id="applicationBean" class="bean.Documento"scope="application" />
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MainPage ADMIN</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/mystyle.css" type="text/css" />
</head>
<script src="scripts/forms.js" type="text/javascript"></script>
<body onload="caricaDocumento()">
	<div id="container">
		<div id="body">
		
		<a class="button" href="login.jsp">BACK</a>
		<fieldset><legend>ModificaForm</legend>
		<form name="godmode" onsubmit="eseguiModifiche(this)">
			<%
				for(Autore autore : applicationBean.getList()){
			%>
			<textarea id="<%=autore.getNome().toLowerCase()%>" name="<%=autore.getNome().toLowerCase()%>" rows="1" cols="50" value="<%=autore.getNome()%>"/>
			<textarea id="pezzo<%=autore.getNome()%>" name="pezzo<%=autore.getNome()%>" rows="50" cols="50" value="<%=autore.getPezzo()%>"/>
			<%
				}
			%>
			<input type="submit" value="Esegui modifiche"/>
		</form>
		</div>
	</div>
</body>
</html>