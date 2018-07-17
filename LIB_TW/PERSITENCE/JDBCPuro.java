//	____________
//	|   JDBC   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯
//  La libreria base di interazione con una Base di Dati in ambiente Java è JDBC, questa
//  specifica libreria sfrutta un DriverJDBC specifico per ogni tipologia si DB 
//  (nel nostro caso DB2).
//  La libreria espone alcune interfaccia che vengono implementate nelle classi specifiche
//  del DriverJDBC, le più importanti sono:
//      Driver ---> punto di partenza per ottenere una connessione al DB
//      DriverManager ---> facilita la gestione degli oggetti Driver (se ve ne sono diversi)
//      Connection ---> rappresenta una connessione attiva con un DB
//      Statement --->  Classe base degli oggetti usati per inviare richieste al DB
//                      le classi che implementano questa interfaccia sono:
//                      - PreparedStatement ---> usato per query parametriche o precompilate
//                      - CallableStatemant ---> usato per query parametriche con parametri IN, OUT ed INOUT
//      ResultSet ---> interfaccia alla base dell' oggetto che sta alla base delle risposte del DB,

//	________________
//	|   SATEMENT   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Gli oggetti di tipo statement possono essere usati per inviare query SQL semplici, quindi senza parametri,
//  nel caso di query più complesse è possibile usare istanzedi altre due classi derivate:
Statement stmt = conn.createStatement();
//  Per eseguire la query ci sono 3 distinti metodi:
ResultSet rs = stmt.executeQuery("SELCT ...");
int result = stmt.executeUpdate("UPDATE ..."); // si usa anche per INSERT e DELETE
boolean result = stmt.execute("..."); //si usa quando la uery ritorna piu ResultSet, vengono salvati nell'oggetto Statement
//  Nel caso si usi il metodo .execute("...") per accedere ai ResultSet o hai contatori di aggiornamento,
//  si devono usare i seguenti metodi:
stmt.getResultSet() // per ottenere il result set successivo
stmt.getUpdateCount() // per ottenere il contatore di aggiornamento successivo
stmt.getMoreResults() // per sapere se ci sono altri result set o contatori di aggiornamento
//  Il metodo .execute("...") restituisce un boolean TRUE se il primo risultato è un ResultSet,
//  mentre un FALSE se il primo result set è di tipo Count o non ci sono risultati. 
//
//  PreparedStatement permette di sfruttare query parametriche e precompilate, il valore di ciascun parametro 
//  nella stringa della query viene sostituito con il carattere '?'.
//  L'istanziamento di una classe PreparedStatement avviene:
PreparedStament pstmt = conn.prepareStatement("SELCT ...");
//  in seguito all'istanziamento devono essere settati i parametri con il seguente metodo:
pstmt.setXXX(nParam, valParam);
//  che accetta come primo argomento il numero del parametro (partendo da 1) e come secondo argomento il valore da impostare.
//  In seguito alla compilazione della PreparedStatement si può eseguire la query con i seguenti metodi
pstmt.executeQuery();   //esegue query SQL ritornando un result set (si usa per la SELECT)
pstmt.executeUpdate();  //esegue querySQL ritornando un intero (si usa per DELETE, INSERT ed UPDATE)
pstmt.execute();    //esegue una qualunque query ritornando un boolean
//
//  CallableStatement è usata per definire query parametriche con parametri di tipo IN, OUT ed INOUT, permette di sesguire
//  un invocazione ad una STORED PROCEDURE memorizzata sul server DB, può essere creata con il metodo:
CallableStatement cstmt = conn.prepareCall();

//	__________________
//	|   RESULT SET   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  L'oggetto ResultSet è il risultato di una  query del tipo SELECT, rappresenta una tabella composta da 
//  righe (gli elementi selezionati) e colonne (gli attributi richiesti).
//  I i valori degli attributi sono accedibili mendiante un cursore e metodi:
rs.getXXX("nomeArg");
rs.getXXX(nColonna);  //il numero colonna è un intero che inizia da 0
//  Per scorrere le tuple del risultato invece si usa il metodo:
rs.next();
//
//  I valori NULL SQL sono convertiti in null, 0, o false, dipendentemente dal tipo di metodo getXXX
//  Per determinare se un particolare valore di un risultato corrisponde a NULL in JDBC:
//  - Si legge la colonna
//  - Si usa il metodo rs.wasNull();

//  Un esempio di programma JDBC può essere:
import java.sql.*; //importo il package JDBC

class Esempio
{
    public static void main(String argv[]) 
    {
        Drive d = Class.forName("com.ibm.db2.jcc.DB2Driver").newInstance();  //carico e registro il driver JDBC
        
        //ci pensa il tryWhithResource a chiudere la Connection
        try (Connection conn = DriverManager.getConnection("jdbc:db2://diva.disi.unibo.it:50000/DATABASE", null/*USER*/, null/*PASSWORD*/))
        {
            Statement stmt = conn.createStatement(); // creo lo statement
            ResultSet rs = stmt.executeQuery("SELECT * FROM MyTable"); //eseguo la query ed istanzop il ResultSet con il risultato
            while (rs.next()) 
            {
                System.out.println(rs.getString("arg1")); //ricavo il valore con il nome dell'attributo
                System.out.println(rs.getString(2)); //ricavo il valore con il numero della colonna

            }
            rs.close(); //chiudo il ResultSet
            stmt.close(); //chiudo lo Statement

            //  nel caso avessi una query parametrizzata avrei dovuto istanziare una PreparedStatement:
            PreparedStatement pstmt = conn.prepareStatement("UPDATE MyTable SET a = ? WHERE b = ?");
            pstmt.setInt(1, 20); //setto un 20 nel primo parametro
            pstmt.setInt(2,100); //setto un 100 nel secondo parametro
            int res = pstmt.executeUpdate(); //eseguo la query ed in questo caso ritorno il numero di tuple modificate
            System.out.println("Ho modificato " + res + "tuple");
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
}
//  nel caso avessi una query parametrizzata avrei dovuto istanziare una PreparedStatement:
PreparedStatement ps = conn.prepareStatement("UPDATE MyTable SET a = ? WHERE b = ?");