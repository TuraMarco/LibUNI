public interface Object1Object2MappingDAO
{
	// --- CRUD -------------

	public void create(Object1Object2MappingDAO mapping);

	public Object1Object2MappingDAO read(int object1Id, int object2Id);

	//public boolean update(CourseDTO student);

	public boolean delete(int object1Id, int object2Id);

	
	// --- ALTRI METODI DI ACCESSO --------

	public List<Object1Object2MappingDAO> findCoursesByObject1Id(int object1Id);
	public List<Object1Object2MappingDAO> findCoursesByObject2Id(int object2Id);

	// --- UTILITY --------------
	
	public boolean createTable();

	public boolean dropTable();
}
