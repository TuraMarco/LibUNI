package bean;

public class LoginInfo 
{
	public static String LOGIN_INFO = "loginInfo";
	private String name;
	private boolean logged = false;
	
	public LoginInfo(String name) 
	{
		this.name = name;
		this.logged = true;
	}

	public String getName() 
	{
		return name;
	}
	
	public boolean isLogged()
	{
		return logged;
	}
}
