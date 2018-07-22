package bean;

public class Autore 
{
	private String nome;
	private String pezzo;
	
	public Autore(){}

	public String getNome() 
	{
		return nome;
	}

	public void setNome(String nome)
	{
		this.nome = nome;
	}

	public String getPezzo() 
	{
		return pezzo;
	}

	public void setPezzo(String pezzo) 
	{
		this.pezzo = pezzo;
	}

	@Override
	public String toString() 
	{
		return nome + "\n" + pezzo + "\n";
	}
}

