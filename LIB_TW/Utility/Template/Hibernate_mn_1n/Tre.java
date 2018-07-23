package esame.hibernate.beans;

import java.io.Serializable;

public class Tre implements Serializable{
	private static final long serialVersionUID = 1L;

	private long id;
	private String tre1;
	private String tre2;
	private Due due;
	
	public Tre(){
		
	}
	
	public Tre(String tre1, String tre2, Due due) {
		super();
		this.tre1 = tre1;
		this.tre2 = tre2;
		this.due = due; //1*n
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTre1() {
		return tre1;
	}

	public void setTre1(String tre1) {
		this.tre1 = tre1;
	}

	public String getTre2() {
		return tre2;
	}

	public void setTre2(String tre2) {
		this.tre2 = tre2;
	}

	public Due getDue() {
		return due;
	}

	public void setDue(Due due) {
		this.due = due;
	}

	@Override
	public String toString() {
		return "Tre [id=" + id + ", tre1=" + tre1 + ", tre2=" + tre2 + ", due="
				+ due + "]";
	}
	
	
}