public class Object2DTO implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	// --- CAMPI -----------
	
	private int id;
	private String string;
	
	// --- COSTRUTTORE ----------
	
	public Object2DTO() {}
	
	// --- ACCESSOR --------------
	
	public int getId() 
	{
		return id;
	}

	public void setId(int id) 
	{
		this.id = id;
	}

	public String getString() 
	{
		return string;
	}

	public void setString(String string) 
	{
		this.string = string;
	}

	// --- UTILITY ----------------------------
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
			Object2DTO other = (Object2DTO) obj;
		if (id != other.id)
			return false;
		return true;
	}
}
