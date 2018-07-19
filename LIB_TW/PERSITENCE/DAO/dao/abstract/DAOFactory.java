public abstract class DAOFactory 
{

	// --- LISTA DEI DB SUPPORTATI ---

	/**
	 * Costante associata al DB da usare, in qusto caso DB2
	 */
	public static final int DB2 = 0;
	
	
	// --- METODI DELLA FACTORY ---
	
	/**
	 * Costruttore statico che accetta un intero per identificare il tipo di DB che si 
	 * vuole usare.
	 */
	public static DAOFactory getDAOFactory(int whichFactory) 
	{
		switch (whichFactory) 
		{
		case DB2:
			return new Db2DAOFactory();
		default:
			return null;
		}
	}
	
	
	
	// --- METODI ASTRATTI DELLA FACTORY ---
	
	/**
	 * Metodi per ottenere un istanza dei DAO supportati
	 */
	public abstract Object1DAO getObject1DAO();
	public abstract Object2DAO getObject2DAO();
	public abstract Object1Object2MappingDAO getObject1Object2MappingDAO();

	//TODO Qui vanno inseriti tutti i metodi astratti che la factory concreta deve implementare, ossia una GET per ogni tipo di DAO supportato
}
