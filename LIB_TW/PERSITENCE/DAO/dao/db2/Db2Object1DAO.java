/**
 * Implementazione di query jdbc su una versione hqldb della tabella entry
 * 
 * La scrittura dei metodi DAO con JDBC segue sempre e comunque questo schema:
 * 
	// --- 1. Dichiarazione della variabile per il risultato ---
	// --- 2. Controlli preliminari sui dati in ingresso ---
	// --- 3. Apertura della connessione ---
	// --- 4. Tentativo di accesso al db e impostazione del risultato ---
	// --- 5. Gestione di eventuali eccezioni ---
	// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
	// --- 7. Restituzione del risultato (eventualmente di fallimento)
 * 
 * Inoltre, all'interno di uno statement JDBC si segue lo schema generale
 * 
	// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
	// --- b. Pulisci e imposta i parametri (se ve ne sono)
	// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
	// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
	// --- e. Rilascia la struttura dati del risultato
	// --- f. Rilascia la struttura dati dello statement
 */
public class Db2Object1DAO implements Object1DAO 
{
	// === Costanti letterali per non sbagliarsi a scrivere !!! ============================
	
	static final String TABLE = "table1"; //TODO

	// -------------------------------------------------------------------------------------

	static final String ID = "id";	//TODO
	static final String STRING = "string"; //TODO
	
	// == STATEMENT SQL ====================================================================

	// INSERT INTO table1 ( id, string) VALUES ( ?,?);
	static final String insert_SQL = 
		"INSERT " +
			"INTO " + TABLE + " ( " + 
				ID +", "+STRING+" " +
			") " +
			"VALUES (?,?) "
		;
	
	// SELECT * FROM table1 WHERE id = ?;
	static String read_by_id_SQL = 
		"SELECT * " +
			"FROM " + TABLE + " " +
			"WHERE " + ID + " = ? "
		;

	// SELECT * FROM table1;
	static String read_all_SQL = 
		"SELECT * " +
		"FROM " + TABLE + " ";
	
	static String read_by_string_SQL = 
		read_all +
			"WHERE " + STRING + " = ? ";
	
	// DELETE FROM table1 WHERE string = ?;
	static String delete_SQL = 
		"DELETE " +
			"FROM " + TABLE + " " +
			"WHERE " + ID + " = ? "
		;

	// UPDATE table1 SET string = ? WHERE id = ?;
	static String update_SQL = 
		"UPDATE " + TABLE + " " +
			"SET " + 
				STRING + " = ? " +
			"WHERE " + ID + " = ? "
		;

	// -------------------------------------------------------------------------------------

	// CREATE entrytable1 ( code INT NOT NULL PRIMARY KEY, ... );
	static String create_SQL = 
		"CREATE " +
			"TABLE " + TABLE +" ( " +
				ID + " INT NOT NULL PRIMARY KEY, " +
				STRING + " VARCHAR(50), " +
			") "
		;
	
	static String drop_SQL = 
		"DROP " +
			"TABLE " + TABLE + " "
		;
	
	// === METODI DAO =========================================================================
	
	/**
	 * C
	 */
	public void create(Object1DTO t) 
	{
		// --- 1. Dichiarazione della variabile per il risultato ---
		//Long result = new Long(-1);
		// --- 2. Controlli preliminari sui dati in ingresso ---
		/*if ( t == null )  {
			logger.warning("create(): failed to insert a null entry");
			return result;
		}*/
		// --- 3. Apertura della connessione ---
		Connection conn = Db2DAOFactory.createConnection();
		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try
		{
			// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
			PreparedStatement prep_stmt = conn.prepareStatement(insert_SQL);
			// --- b. Pulisci e imposta i parametri (se ve ne sono)
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, t.getId());
			prep_stmt.setString(2, t.getString());
			// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
			prep_stmt.executeUpdate();
			// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
			// n.d.
			// --- e. Rilascia la struttura dati del risultato
			// n.d.
			// --- f. Rilascia la struttura dati dello statement
			prep_stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) 
		{
			logger.warning("create(): failed to insert entry: " + e.getMessage());
			e.printStackTrace();
			//result = new Long(-2);
		}
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}

		// Nel caso della creazione di una nuova tupla eseguo un secondo accesso per sapere che code le e' stato assegnato
		// Chiaramente e' inutile farlo se già il primo accesso ha prodotto errori
		// --- 6./7. Chiusura della connessione in caso di errori e restituizione prematura di un risultato di fallimento
		/*if ( result == -2 ) {
			Db2DAOFactory.closeConnection(conn);
			return result;
		}
		
		// --- 1. Dichiarazione della variabile per il risultato ---
		// riutilizziamo quella di prima

		// --- 2. Controlli preliminari sui dati in ingresso ---
		// gia'� fatti

		// --- 3. Apertura della connessione ---
		// ce n'e' una gia'� aperta, se siamo qui

		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Db2StudentDAO.lastInsert);
			if ( rs.next() ) {
				result = rs.getLong(1);
			}		
			rs.close();
			stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) {
			logger.warning("create(): failed to retrieve id of last inserted entry: "+e.getMessage());
			e.printStackTrace();
		}
		// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
		finally {
			Db2DAOFactory.closeConnection(conn);
		}
		// --- 7. Restituzione del risultato (eventualmente di fallimento)
		return result;*/
	}

	// -------------------------------------------------------------------------------------

	/**
	 * R
	 */
	public Object1DTO read(int id) 
	{
		// --- 1. Dichiarazione della variabile per il risultato ---
		Object1DTO result = null;
		// --- 2. Controlli preliminari sui dati in ingresso ---
		if ( id < 0 )  
		{
			// logger.warning("read(): cannot read an entry with a negative id");
			return result;
		}
		// --- 3. Apertura della connessione ---
		Connection conn = Db2DAOFactory.createConnection();
		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try 
		{
			// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
			PreparedStatement prep_stmt = conn.prepareStatement(read_by_id_SQL);
			// --- b. Pulisci e imposta i parametri (se ve ne sono)
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, id);
			// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
			ResultSet rs = prep_stmt.executeQuery();
			// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
			if ( rs.next() ) {
				Object1DTO entry = new Object1DTO();
				entry.setId(rs.getInt(ID));
				entry.setString(rs.getString(STRING));
				// long secs = rs.getDate(BIRTHDATE).getTime();
				// java.util.Date birthDate = new java.util.Date(secs);
				// entry.setBirthDate(birthDate);
				result = entry;
			}
			// --- e. Rilascia la struttura dati del risultato
			rs.close();
			// --- f. Rilascia la struttura dati dello statement
			prep_stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) 
		{
			//logger.warning("read(): failed to retrieve entry with id = " + id+": "+e.getMessage());
			e.printStackTrace();
		}
		// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		// --- 7. Restituzione del risultato (eventualmente di fallimento)
		return result;
	}

	// -------------------------------------------------------------------------------------

	/**
	 * U
	 */
	public boolean update(Object1DTO t) 
	{
		// --- 1. Dichiarazione della variabile per il risultato ---
		boolean result = false;
		// --- 2. Controlli preliminari sui dati in ingresso ---
		if ( t == null )  
		{
			//logger.warning( "update(): failed to update a null entry");
			return result;
		}
		// --- 3. Apertura della connessione ---
		Connection conn = Db2DAOFactory.createConnection();
		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try 
		{
			// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
			PreparedStatement prep_stmt = conn.prepareStatement(update_SQL);
			// --- b. Pulisci e imposta i parametri (se ve ne sono)
			prep_stmt.clearParameters();
			prep_stmt.setString(1, t.getString());
			prep_stmt.setInt(2, t.getId());
			// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
			prep_stmt.executeUpdate();
			// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
			// n.d. qui devo solo dire al chiamante che e' andato tutto liscio
			result = true;
			// --- e. Rilascia la struttura dati del risultato
			// n.d.
			// --- f. Rilascia la struttura dati dello statement
			prep_stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) 
		{
			//logger.warning("insert(): failed to update entry: "+e.getMessage());
			e.printStackTrace();
		}
		// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		// --- 7. Restituzione del risultato (eventualmente di fallimento)
		return result;
	}

	// -------------------------------------------------------------------------------------

	/**
	 * D
	 */
	public boolean delete(int id) 
	{
		// --- 1. Dichiarazione della variabile per il risultato ---
		boolean result = false;
		// --- 2. Controlli preliminari sui dati in ingresso ---
		//if ( code == null || code < 0 )  {
		if ( id < 0 ) 
		{
			//logger.warning("delete(): cannot delete an entry with an invalid id ");
			return result;
		}
		// --- 3. Apertura della connessione ---
		Connection conn = Db2DAOFactory.createConnection();
		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try 
		{
			// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
			PreparedStatement prep_stmt = conn.prepareStatement(delete_SQL);
			// --- b. Pulisci e imposta i parametri (se ve ne sono)
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, id);
			// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
			prep_stmt.executeUpdate();
			// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
			// n.d. Qui devo solo dire al chiamante che e' andato tutto liscio
			result = true;
			// --- e. Rilascia la struttura dati del risultato
			// n.d.
			// --- f. Rilascia la struttura dati dello statement
			prep_stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) 
		{
			//logger.warning("delete(): failed to delete entry with id = " + id+": "+e.getMessage());
			e.printStackTrace();
		}
		// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		// --- 7. Restituzione del risultato (eventualmente di fallimento)
		return result;
	}

	// -------------------------------------------------------------------------------------

	/**
	 * Find by name
	 */
	public List<Object1DTO> findObject1ByString(String string) {
		// --- 1. Dichiarazione della variabile per il risultato ---
		List<Object1DTO> result = new ArrayList<Object1DTO>();
		// --- 2. Controlli preliminari sui dati in ingresso ---
		if ( string == null || string.equals("") )
		{
			//logger.warning("findObject1ByString(): string is invalid");
			return result;
		}
		// --- 3. Apertura della connessione ---
		Connection conn = Db2DAOFactory.createConnection();
		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try 
		{
			// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
			PreparedStatement prep_stmt = conn.prepareStatement(read_by_string_SQL);
			// --- b. Pulisci e imposta i parametri (se ve ne sono)
			prep_stmt.clearParameters();
			prep_stmt.setString(1, string);
			// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
			ResultSet rs = prep_stmt.executeQuery();
			// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
			while ( rs.next() ) {
				Object1DTO entry = new Object1DTO();
				entry.setId(rs.getInt(ID));
				entry.setString(rs.getString(STRING));
				// long secs = rs.getDate(BIRTHDATE).getTime();
				// entry.setBirthDate(new java.util.Date(secs));
				result.add( entry );
			}
			// --- e. Rilascia la struttura dati del risultato
			rs.close();
			// --- f. Rilascia la struttura dati dello statement
			prep_stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) {
			//logger.warning("find(): failed to retrieve entry with string = " + string + ": "+e.getMessage());
			e.printStackTrace();
		}
		// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
		finally {
			Db2DAOFactory.closeConnection(conn);
		}
		// --- 7. Restituzione del risultato (eventualmente di fallimento)
		return result;
	}

	// -------------------------------------------------------------------------------------
	// -------------------------------------------------------------------------------------
	// -------------------------------------------------------------------------------------

	/**
	 * Creazione della table1
	 */
	public boolean createTable() {
		// --- 1. Dichiarazione della variabile per il risultato ---
		boolean result = false;
		// --- 2. Controlli preliminari sui dati in ingresso ---
		// n.d.
		// --- 3. Apertura della connessione ---
		Connection conn = Db2DAOFactory.createConnection();
		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try {
			// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
			Statement stmt = conn.createStatement();
			// --- b. Pulisci e imposta i parametri (se ve ne sono)
			// n.d.
			// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
			stmt.execute(create);
			// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
			// n.d. Qui devo solo dire al chiamante che è andato tutto liscio
			result = true;
			// --- e. Rilascia la struttura dati del risultato
			// n.d.
			// --- f. Rilascia la struttura dati dello statement
			stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) 
		{
			//logger.warning("createTable(): failed to create table '"+TABLE+"': "+e.getMessage());
			e.printStackTrace();
		}
		// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		// --- 7. Restituzione del risultato (eventualmente di fallimento)
		return result;
	}

	// -------------------------------------------------------------------------------------

	/**
	 * Rimozione della table1
	 */
	public boolean dropTable() 
	{
		// --- 1. Dichiarazione della variabile per il risultato ---
		boolean result = false;
		// --- 2. Controlli preliminari sui dati in ingresso ---
		// n.d.
		// --- 3. Apertura della connessione ---
		Connection conn = Db2DAOFactory.createConnection();
		// --- 4. Tentativo di accesso al db e impostazione del risultato ---
		try
		{
			// --- a. Crea (se senza parametri) o prepara (se con parametri) lo statement
			Statement stmt = conn.createStatement();
			// --- b. Pulisci e imposta i parametri (se ve ne sono)
			// n.d.
			// --- c. Esegui l'azione sul database ed estrai il risultato (se atteso)
			stmt.execute(drop);
			// --- d. Cicla sul risultato (se presente) pe accedere ai valori di ogni sua tupla
			// n.d. Qui devo solo dire al chiamante che è andato tutto a posto.
			result = true;
			// --- e. Rilascia la struttura dati del risultato
			// n.d.
			// --- f. Rilascia la struttura dati dello statement
			stmt.close();
		}
		// --- 5. Gestione di eventuali eccezioni ---
		catch (Exception e) 
		{
			//logger.warning("dropTable(): failed to drop table '"+TABLE+"': "+e.getMessage());
			e.printStackTrace();
		}
		// --- 6. Rilascio, SEMPRE E COMUNQUE, la connessione prima di restituire il controllo al chiamante
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		// --- 7. Restituzione del risultato (eventualmente di fallimento)
		return result;
	}
}