package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.LoginInfo;

public class LoginServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	public static final String LOGGED_USERS = "loggedUsers";
	
	private String firstPageAfterLogin;
	private String adminPageAfterLogin;
	
	@Override
	public void init() throws ServletException 
	{
		super.init();
		firstPageAfterLogin = this.getServletContext().getInitParameter("firstPageAfterLogin");
		adminPageAfterLogin = this.getServletContext().getInitParameter("adminPageAfterLogin");
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();

		if (session.getAttribute(LoginInfo.LOGIN_INFO) == null) 
		{
			// Carico user e passwd su due variabili
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			if (username == null || password == null) 
			{
				// nel caso l'utente sia sloggato su di una pagina che richiede il login
				getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			} 
			else 
			{
				LoginInfo li = (LoginInfo) session.getAttribute(LoginInfo.LOGIN_INFO);
				// coming from login.jsp after form submission
				if (checkCredentialis(username, password) && !li.isLogged()) 
				{
					if (username.equals("admin") && password.equals("admin")) 
					{
						session.setAttribute(LoginInfo.LOGIN_INFO, new LoginInfo(username));
						response.sendRedirect(request.getContextPath() + adminPageAfterLogin);
					} 
					else 
					{
						session.setAttribute(LoginInfo.LOGIN_INFO, new LoginInfo(username));
						response.sendRedirect(request.getContextPath() + firstPageAfterLogin);
					}
				} 
				else 
				{
					getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
				}
			}
		} 
	}
	
	private boolean checkCredentialis(String username, String password) 
	{
		// accetto qualunque login
		return true;
	}
}
