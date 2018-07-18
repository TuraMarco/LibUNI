public class Db2DAOFactory extends DAOFactory 
{

	/**
	 * Nome della classe che implementa il JDBC Driver di DB2
	 */
	public static final String DRIVER = "com.ibm.db2.jcc.DB2Driver";
	
	/**
	 * Dati per chiedere la connessione ad un DB specifico
	 */
	public static final String DBURL = "jdbc:db2://diva.deis.unibo.it:50000/sit_stud";
	public static final String USERNAME = "xxx"; //TODO
	public static final String PASSWORD = "yyy"; //TODO

	// --------------------------------------------

	/**
	 * Carico la classe JDBC Driver in memoria
	 */
	static 
	{
		try 
		{
			Class.forName(DRIVER);
		} 
		catch (Exception e) 
		{
			System.err.println("DB2DAOFactory: fallito il caricamento del JDBC Driver: " + DRIVER + "\n" + e.toString());
			e.printStackTrace();
		}
	}

	// --------------------------------------------

	/**
	 * Codice per creare una connection, viene creata una nuova connessione tutte le volte che viene chiesta, in realtà non si fa!!!!
	 */
	public static Connection createConnection() 
	{
		try 
		{
			return DriverManager.getConnection(DBURL,USERNAME,PASSWORD);
		} 
		catch (Exception e) 
		{
			System.err.println(Db2DAOFactory.class.getName() + ".createConnection(): fallita la creazione della connection" + "\n" + e.toString());
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * Codice per chiudere una connection creata con il metodo precedente.
	 */
	public static void closeConnection(Connection conn) 
	{
		try 
		{
			conn.close();
		}
		catch (Exception e) 
		{
			System.err.println(Db2DAOFactory.class.getName() + ".closeConnection(): fallita la chiusura della connection" + "\n" + e.toString());
			e.printStackTrace();
		}
	}

	// --------------------------------------------
	
	/**
	 * Metodi concreti dell classe factory per istanziare oggetti DAO 
	 */
	@Override
	public Object1DAO getObject1DAO() 
	{
		return new Db2Object1DAO();
	}

	@Override
	public Object2DAO getObject2DAO() 
	{
		return new Db2Object2DAO();
	}
	
	@Override
	public Object1Object2MappingDAO getObject1Object2MappingDAO() 
	{
		return new Db2Object1Object2MappingDAO();
	}
	
	//TODO Qui vanno inseriti tutti i metodi concreti che la factory concreta deve implementare, ossia una GET per ogni tipo di DAO supportato
}
