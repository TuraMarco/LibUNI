package servlet;

import java.io.IOException;

//import java.io.BufferedReader;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.net.MalformedURLException;
//import java.net.URL;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jabsorb.JSONSerializer;
import org.jabsorb.serializer.MarshallException;

import bean.Autore;
import bean.Documento;

public class JsonServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	private JSONSerializer serializer;

	private Documento documento;

	@Override
	public void init() throws ServletException 
	{
		super.init();

		serializer = new JSONSerializer();

		ServletContext application = this.getServletContext();
		synchronized (application)  //GESTIONE CONCORRENZA
		{
			documento = (Documento) application.getAttribute("applicationBean");
			
			if (documento == null) // se il documento è vuoto lo inizializzo
			{
				documento = new Documento();
				Autore aut1 = new Autore();
				aut1.setNome("Federico");
				aut1.setPezzo("Nel mezzo del cammin di nostra vita,\nmi ritrovai per una selva oscura\n");
				Autore aut2 = new Autore();
				aut2.setNome("Giovanni");
				aut2.setPezzo("Che la diritta via era smarrita\nAhi quanto a dir qual era � cosa dura\n");
				Autore aut3 = new Autore();
				aut3.setNome("DanteLOL");
				aut3.setPezzo("Esta selva selvaggia et aspra et forte\nche nel pensier rinnova la paura\n");
				application.setAttribute("applicationBean", documento); //una volta aggiornato lo riimmetto nell'application contest come attributo
			}
		}

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
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 //Questo era nel caso in cui avesse cercato un documento nel FS
//		 if (documento != null && documento.getList() != null && documento.getList().size() != 0) 
//		 {
//			 StringBuilder sb = new StringBuilder();
//			 InputStream is = null;
//			 try 
//			 {
//				 URL file = this.getServletContext().getResource("/" + documento);
//				 is = file.openStream();
//				 BufferedReader br = new BufferedReader(new InputStreamReader(is));
//				 String line;
//				 Autore auth = new Autore();
//				 while ((line = br.readLine()) != null) 
//				 {
//					 if (line.split(" ").length == 1)
//					 {
//						 if (auth.getNome() == null) 
//						 {
//							 auth.setNome(line);
//						 }
//						 if (auth.getNome() != null && sb.toString().length() != 0) 
//						 {
//							 auth.setPezzo(sb.toString());
//							 documento.add(auth);
//							 sb = new StringBuilder();
//							 auth.setNome(line);
//						 }
//					 } 
//					 else 
//					 {
//						 sb.append(line);
//					 }
//				 }
//			 } 
//			 catch (MalformedURLException mue) 
//			 {
//				 mue.printStackTrace();
//			 } 
//			 catch (IOException ioe) 
//			 {
//				 ioe.printStackTrace();
//			 } 
//			 catch (Exception e) 
//			 {
//				 e.printStackTrace();
//			 } 
//			 finally 
//			 {
//				 try 
//				 {
//					 if (is != null) 
//					 {
//						 is.close();
//					 }	 
//				 } 
//				 catch (IOException iOe){}
//			 }
//		}

		try 
		{
			String serializedObject = serializer.toJSON(documento);
			request.setAttribute("jsonDocument", serializedObject);
		} 
		catch (MarshallException e) 
		{
			e.printStackTrace();
		}
	}
}
