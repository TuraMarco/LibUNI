<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="servlet.LoginServlet"%>
<%@ page import="bean.LoginInfo"%>

<!-- Se è già loggato faccio il forward alla servlet -->
<%
	if (session.getAttribute(LoginInfo.LOGIN_INFO) != null) {
%>
<jsp:forward page="loginServlet" />
<%
	} 
	else 
	{
%>
<!-- Se non è già loggato mostro la form di login -->
<html>
	<head>
		<title>LoginJSP</title>
		<link rel="stylesheet" href="styles/default.css" type="text/css"></link>
	</head>
	<body>
       	<fieldset><legend>Login</legend>
		<form name="login" action="loginServlet" method="post">
			<label for="username">Username</label> 
			<input type="text" name="username" placeholder="username" required> <br /> 
			<label for="password">Password</label> 
			<input type="password" name="password" placeholder="password" required> <br /> 
			<input type="submit" value="Login">
		</form>
		</fieldset> 
	</body>
</html>
<%
	}
%>