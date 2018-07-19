/**
    CREATE TABLE UTENTE(
        username VARCHAR(10) PRIMARY KEY,
        nome VARCHAR(15),
        cognome VARCHAR(15),
        cod_fis VARCHAR(16) UNIQUE,
        password VARCHAR(8),
        email VARCHAR(20),
        via VARCHAR(20),
        civico INT,
        cap VARCHAR(5),
        citta VARCHAR(15)
    );
 */
public class User 
{
    private String nome;
    private String cognome;
    private String username; // è l'identificatore all'interno del DB quindi il metodo set deve essere privato, essendo inmodificabile
    private String password;
    private String email;
    private Indirizzo indirizzo; // altra classe Indirizzo.java con 4 campi privati: via, civico, cap, città, e Accessor publici
    
    public User(){}

    public User(String user)
    {
        username=user;
    }
     /**
      * GETTER & SETTER
     */
}