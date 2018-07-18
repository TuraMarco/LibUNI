public interface Object1DAO
{

	// --- CRUD -------------

	public void create(Object1DAO o1);

	public Object1DAO read(int code);

	public boolean update(Object1DAO o1);

	public boolean delete(int code);

	
	// --- ALTRI METODI DI ACCESSO ------

	public List<Object1DAO> findObject1ByString(String string);

	// --- ALTRI METODI --------
	
	public boolean createTable();

	public boolean dropTable();

}
