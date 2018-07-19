public interface Object2DAO
{

	// --- CRUD -------------

	public void create(Object2DAO o1);

	public Object2DAO read(int code);

	public boolean update(Object2DAO o1);

	public boolean delete(int code);

	
	// --- ALTRI METODI DI ACCESSO ------

	public List<Object2DAO> findObject1ByString(String string);

	// --- ALTRI METODI --------
	
	public boolean createTable();

	public boolean dropTable();

}
