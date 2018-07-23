package esame.hibernate.beans;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Due implements Serializable{
	private static final long serialVersionUID = 1L;

	private long id;
	private String due1;
	private String due2;
	private Set<Uno> unos; //m*N
	private Set<Tre> tres; //1*N
	
	public Due() {
		super();
	}

	public Due(String due1, String due2) {
		super();
		this.due1 = due1;
		this.due2 = due2;
		this.unos = new HashSet<Uno>();
		this.tres = new HashSet<Tre>();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDue1() {
		return due1;
	}

	public void setDue1(String due1) {
		this.due1 = due1;
	}

	public String getDue2() {
		return due2;
	}

	public void setDue2(String due2) {
		this.due2 = due2;
	}

	public Set<Uno> getUnos() {
		return unos;
	}

	public void setUnos(Set<Uno> unos) {
		this.unos = unos;
	}

	public Set<Tre> getTres() {
		return tres;
	}

	public void setTres(Set<Tre> tres) {
		this.tres = tres;
	}

	@Override
	public String toString() {
		return "Due [id=" + id + ", due1=" + due1 + ", due2=" + due2
				+ ", unos=" + unos + ", tres=" + tres + "]";
	}
	
	
}