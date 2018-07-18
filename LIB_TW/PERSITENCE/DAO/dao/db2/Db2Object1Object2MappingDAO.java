public class Db2Object1Object2MappingDAO implements Object1Object2MappingDAO 
{

	// === Costanti letterali per non sbagliarsi a scrivere !!! ============================
	
	static final String TABLE = "object1_object2";

	// -------------------------------------------------------------------------------------

	static final String ID_1 = "Object1id";
	static final String ID_2 = "Object2id";
	
	
	// == STATEMENT SQL ====================================================================

	// INSERT INTO table ( idCourse, idStudent ) VALUES ( ?,? );
	static final String insert = 
		"INSERT " +
			"INTO " + TABLE + " ( " + 
				ID_1 +", "+ID_2 + " " +
			") " +
			"VALUES (?,?) "
		;
	
	// SELECT * FROM table WHERE idcolumns = ?;
	static String read_by_ids = 
		"SELECT * " +
			"FROM " + TABLE + " " +
			"WHERE " + ID_1 + " = ? " +
			"AND " + ID_2 + " = ? "
		;

	// SELECT * FROM table WHERE idcolumns = ?;
	static String read_by_id_1 = 
		"SELECT * " +
			"FROM " + TABLE + " " +
			"WHERE " + ID_1 + " = ? "
		;

	// SELECT * FROM table WHERE idcolumns = ?;
	static String read_by_id_2 = 
		"SELECT * " +
			"FROM " + TABLE + " " +
			"WHERE " + ID_2 + " = ? "
		;
	
	// SELECT * FROM table WHERE stringcolumn = ?;
	static String read_all = 
		"SELECT * " +
		"FROM " + TABLE + " ";
	
	// DELETE FROM table WHERE idcolumn = ?;
	static String delete = 
		"DELETE " +
			"FROM " + TABLE + " " +
			"WHERE " + ID_1 + " = ? " +
			"AND " + ID_2 + " = ? "
		;

	// UPDATE table SET xxxcolumn = ?, ... WHERE idcolumn = ?;
	/*static String update = 
		"UPDATE " + TABLE + " " +
			"SET " + 
				NAME + " = ?, " +
			"WHERE " + ID + " = ? "
		;*/

	// SELECT * FROM table;
	static String query = 
		"SELECT * " +
			"FROM " + TABLE + " "
		;

	// -------------------------------------------------------------------------------------

	// CREATE entrytable ( code INT NOT NULL PRIMARY KEY, ... );
	static String create = 
		"CREATE " +
			"TABLE " + TABLE +" ( " +
				ID_1 + " INT NOT NULL, " +
				ID_2 + " INT NOT NULL, " +
				"PRIMARY KEY (" + ID_1 +","+ ID_2 + " ) " +
			") "
		;
	static String drop = 
		"DROP " +
			"TABLE " + TABLE + " "
		;
	
	
	// === METODI DAO =========================================================================
	
	@Override
	public void create(Object1Object2MappingDTO mapping) 
	{
		Connection conn = Db2DAOFactory.createConnection();
		try 
		{
			PreparedStatement prep_stmt = conn.prepareStatement(insert);
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, mapping.getObject1Id());
			prep_stmt.setInt(2, mapping.getObject2Id());
			prep_stmt.executeUpdate();
			prep_stmt.close();
		}
		catch (Exception e) 
		{
			//System.out.println("create(): failed to insert entry: " + e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	public Object1Object2MappingDTO read(int id1, int id2) 
	{
		Object1Object2MappingDTO result = null;
		if ( id1 < 0 || id2 < 0 )  
		{
			System.out.println("read(): cannot read an entry with a negative id");
			return result;
		}
		Connection conn = Db2DAOFactory.createConnection();
		try 
		{
			PreparedStatement prep_stmt = conn.prepareStatement(read_by_ids);
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, id1);
			prep_stmt.setInt(2, id2);
			ResultSet rs = prep_stmt.executeQuery();
			if ( rs.next() ) 
			{
				Object1Object2MappingDTO entry = new CourseStudentMappingDTO();
				entry.setObject1Id(rs.getInt(ID_1));
				entry.setObject2Id(rs.getInt(ID_2));
				result = entry;
			}
			rs.close();
			prep_stmt.close();
		}
		catch (Exception e) 
		{
			//System.out.println("read(): failed to retrieve entry with idCourse = " + idCourse+" and idStudent = " + idStudent+": "+e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		return result;
	}

	/*@Override
	public boolean update(CourseDTO course) 
	{
		boolean result = false;
		if ( course == null )  {
			System.out.println( "update(): failed to update a null entry");
			return result;
		}
		Connection conn = Db2DAOFactory.createConnection();
		try {
			PreparedStatement prep_stmt = conn.prepareStatement(Db2CourseDAO.update);
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, course.getId());
			prep_stmt.setString(2, course.getName());
			prep_stmt.executeUpdate();
			result = true;
			prep_stmt.close();
		}
		catch (Exception e) {
			System.out.println("insert(): failed to update entry: "+e.getMessage());
			e.printStackTrace();
		}
		finally {
			Db2DAOFactory.closeConnection(conn);
		}
		return result;
	}*/

	@Override
	public boolean delete(int id1, int id2) 
	{
		boolean result = false;
		if ( id1 < 0 || id2 < 0 )  
		{
			//System.out.println("delete(): cannot delete an entry with an invalid id ");
			return result;
		}
		Connection conn = Db2DAOFactory.createConnection();
		try 
		{
			PreparedStatement prep_stmt = conn.prepareStatement(delete);
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, id1);
			prep_stmt.setInt(2, id2);
			prep_stmt.executeUpdate();
			result = true;
			prep_stmt.close();
		}
		catch (Exception e) 
		{
			//System.out.println("delete(): failed to delete entry with idCourse = " + id1 +" and idStudent = " + id2 + ": "+e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		return result;
	}
	
	@Override
	public boolean createTable() 
	{
		boolean result = false;
		Connection conn = Db2DAOFactory.createConnection();
		try 
		{
			Statement stmt = conn.createStatement();
			stmt.execute(create);
			result = true;
			stmt.close();
		}
		catch (Exception e) 
		{
			//System.out.println("createTable(): failed to create table '"+TABLE+"': "+e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		return result;
	}

	@Override
	public boolean dropTable() {
		boolean result = false;
		Connection conn = Db2DAOFactory.createConnection();
		try {
			Statement stmt = conn.createStatement();
			stmt.execute(drop);
			result = true;
			stmt.close();
		}
		catch (Exception e) {
			//System.out.println("dropTable(): failed to drop table '"+TABLE+"': "+e.getMessage());
			e.printStackTrace();
		}
		finally {
			Db2DAOFactory.closeConnection(conn);
		}
		return result;
	}
	
	@Override
	public List<Object1Object2MappingDTO> findCoursesByObject1Id(int id1) 
	{
		List<Object1Object2MappingDTO> result = null;
		if ( id1 < 0 )  
		{
			//System.out.println("read(): cannot read an entry with a negative id");
			return result;
		}
		Connection conn = Db2DAOFactory.createConnection();
		try 
		{
			result = new ArrayList<Object1Object2MappingDTO>();
			PreparedStatement prep_stmt = conn.prepareStatement(read_by_id_1);
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, id1);
			ResultSet rs = prep_stmt.executeQuery();
			while ( rs.next() ) 
			{
				Object1Object2MappingDTO entry = new Object1Object2MappingDTO();
				entry.setObject1Id(rs.getInt(ID_1));
				entry.setObject2Id(rs.getInt(ID_2));
				result.add(entry);
			}
			rs.close();
			prep_stmt.close();
		}
		catch (Exception e) 
		{
			//System.out.println("read(): failed to retrieve entry with idStudent = " + idStudent+": "+e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		return result;
	}

	@Override
	public List<Object1Object2MappingDTO> findCoursesByObject2Id(int id2) 
	{
		List<Object1Object2MappingDTO> result = null;
		if ( id2 < 0 )  
		{
			//System.out.println("read(): cannot read an entry with a negative id");
			return result;
		}
		Connection conn = Db2DAOFactory.createConnection();
		try 
		{
			result = new ArrayList<Object1Object2MappingDTO>();
			PreparedStatement prep_stmt = conn.prepareStatement(read_by_id_2);
			prep_stmt.clearParameters();
			prep_stmt.setInt(1, id2);
			ResultSet rs = prep_stmt.executeQuery();
			while ( rs.next() ) 
			{
				Object1Object2MappingDTO entry = new Object1Object2MappingDTO();
				entry.setObject1Id(rs.getInt(ID_1));
				entry.setObject2Id(rs.getInt(ID_2));
				result.add(entry);
			}
			rs.close();
			prep_stmt.close();
		}
		catch (Exception e) 
		{
			//System.out.println("read(): failed to retrieve entry with idCourse = " + idCourse+": "+e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			Db2DAOFactory.closeConnection(conn);
		}
		return result;
	}
}
