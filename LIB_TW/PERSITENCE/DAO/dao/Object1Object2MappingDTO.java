package it.unibo.tw.dao;

import java.io.Serializable;

public class Object1Object2MappingDTO implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	// --- CAMPI -----------
	
	private int object1Id;
	private int object2Id;
	
	// --- COSTRUTTORE ----------
	
	public CourseStudentMappingDTO() {}
	
	// --- ACCESSOR --------------
	
	public int getObject1Id() 
	{
		return object1Id;
	}

	public void setObject1Id(int object1Id) 
	{
		this.object1Id = object1Id;
	}
	
	public int getObject2Id() 
	{
		return idStudent;
	}

	public void setObject2Id(int object2Id) 
	{
		this.object2Id = object2Id;
	}

	// --- UTILITY ----------------------------

	@Override
	public int hashCode() 
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + object1Id;
		result = prime * result + object2Id;
		return result;
	}

	@Override
	public boolean equals(Object obj) 
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
			Object1Object2MappingDTO other = (Object1Object2MappingDTO) obj;
		if (object1Id != other.object1Id)
			return false;
		if (object2Id != other.object2Id)
			return false;
		return true;
	}	
}
