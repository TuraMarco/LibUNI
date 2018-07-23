package esame.hibernate.beans;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Uno implements Serializable{
	private static final long serialVersionUID = 1L;

	private long id;
	private String uno1;
	private String uno2;
	private Set<Due> dues;
	
	public Uno(){
		
	}
	
	public Uno(String uno1, String uno2) {
		super();
		this.uno1 = uno1;
		this.uno2 = uno2;
		this.dues = new HashSet<Due>(); //M*n
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUno1() {
		return uno1;
	}

	public void setUno1(String uno1) {
		this.uno1 = uno1;
	}

	public String getUno2() {
		return uno2;
	}

	public void setUno2(String uno2) {
		this.uno2 = uno2;
	}

	public Set<Due> getDues() {
		return dues;
	}

	public void setDues(Set<Due> dues) {
		this.dues = dues;
	}

	@Override
	public String toString() {
		return "Uno [id=" + id + ", uno1=" + uno1 + ", uno2=" + uno2 + ", dues=" + dues + "]";
	}
	
	
	
}