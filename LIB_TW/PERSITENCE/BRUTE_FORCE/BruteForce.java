//	____________________
//	|   INTRODUZIONE   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  La metodologia a forza bruta è la più semplice tra quelle possibili per gestire la persistenza, con il
//  contro però di un forte accoppiamento con le sorgenti di dati.
//  In breve consiste nello scrivere dentro le classi del modello un insieme di metodi che assolvono alle 
//  operazioni CRUD.

//	____________
//	|   CRUD   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯
//  Sono le interazioni base eseguite nei confronti di oggetti Java, CRUD è un acronimo che stà per:
//  - CREATE ---> inserimento di una tupla (che rappresenta un oggetto) nel DB (op. sql INSERT)
//  - RETRIVE ---> ricerca di una tupla secondo un criterio specifico all'interno del DB (op. sql SELECT)
//  - UPDATE ---> aggiornamento di una tupla nel DB (op. sql UPDATE)
//  - DELETR ---> eliminazione di una tupla dal DB (op. sql DELETE)
//  Da notare che dell' operazione di RETRIVE possono essercene diverse, in base al criterio di ricerca o alla
//  cardinalità del risultato.
//  
//  L'implementazione di questo "pattern" prevede che per ogni classe MyClass che rappresenta un entità del dominio
//  si definiscano i seguenti metodi:
public class MyClass 
{   	
    private DataSource dataSource; //sorgente che da la connessione al db scielto

    private Object arg1;    //argomenti privati
    private Object arg2;

    public MyClass()    // costruttore senza argomenti publico
    {
        super();
        dataSource = new DataSource(0); //istanzio il driver DB2
    }  

    public void setArg1(Object arg1){this.arg1=arg1;}   //accessor publici
    public void setArg2(Object arg2){this.arg2=arg2;}
    
    // ritorno un istanza di MyClass individuata per chiava
    public MyClass doRetrieveByKey(Object key)
    {
        try (Connection conn = this.dataSource.getConnection())
        {
            PreparedStatement pstmt = conn.prepareStatement("SELECT ......"); //creo un prepared statemnet con la query personalizzata
            pstmt.setObject(1, key); //setto i parametri giusti

            ResultSet rs = pstmt.executeQuery(); // eseguo la query
            while (rs.next()) 
            {
                result.setArg1(rs.getString("arg1")); //ricavo il valore con il nome dell'attributo e lo setto nell'elemento di ritorno
                result.setArg2(rs.getString(2)); 
            }
            rs.close(); 
            stmt.close();
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }

        return result;
    }

    // ritorno una collection di istanze di MyClass
    public List<MyClass> doRetrieveAll(Object key)
    {
        Drive d = Class.forName("com.ibm.db2.jcc.DB2Driver").newInstance();  //carico e registro il driver JDBC
        List<MyClass> result = new ArrayList<MyClass>();

        try (Connection conn = this.dataSource.getConnection())
        {
            PreparedStatement pstmt = conn.prepareStatement("SELECT ......"); //creo un prepared statemnet con la query personalizzata
            pstmt.setObject(1, key); //setto i parametri giusti
            
            ResultSet rs = pstmt.executeQuery(); // eseguo la query
            while (rs.next()) 
            {
                MyClass temp = new MyClass();
                temp.setArg1(rs.getString("arg1")); //ricavo il valore con il nome dell'attributo e lo setto nell'elemento di ritorno
                temp.setArg1(rs.getString(2)); 

                result.add(temp);
            }
            rs.close(); 
            stmt.close();
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }

        return result;
    }

    // salvo o aggiorno un oggetto nel database
    public void saveOrUpdate(MyClass arg){}

    // cancella dal DB i dati del oggetto corrente
    public void doDelete(){}
}