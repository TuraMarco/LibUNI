//	___________
//	|   DAO   |
//  ¯¯¯¯¯¯¯¯¯¯¯
//  Il attern DAO risolve molte problematiche tipiche dell'approccio a forza bruta nella progettazione della persisitenza,
//  tra cui:
//  -   L'accoppiamento tra la sorgente dati e le classi del modello è molto forte
//  -   Le classi del modello sono poco coese (responsabilità eterogenee)
//  -   Molto difficile iniziare a sviluppare senza preoccuparsi di tanti (troppi !) dettagli e senza un ambiente operativo complesso
//  Il pattern Data Access Object (DAO) affidare le responsabilità di interagire con il database ad opportune classi.
//  I componenti della logica di businnes non devono contenere codice che accede al DB, per questo motivo si crea una gerarchia di 
//  nuove classi preposte a questo.

//	___________________
//	|   OGGETTI DTO   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  I valori scambiati tra DB ed applicazione vengono racchiusi in oggetti specifici detti DTO caratterizzati da:
//  -   campi privati
//  -   accessor publici
//  -   metodi di utilità publici o privati in base all'esigenza
//  Le operazioni che coinvolgono tali oggetti sono raggruppate in interfaccia che definiscono i DAO disponibili:
//  -   metodi CRUD
//  -   altri metodi di supporto
//  L'implementazione di tali interfaccia permettono l'effettiva interazione con il DB, permettendo:
//  -   Attraverso diverse implementazioni di accedere a DB di diversi vendor in modo omogeneo
//  -   Semplicità nel migrare su DB differenti
//  -   Separare in modo ottimale le responsabilità tra le parti dell'applicazione
//  Per istanziare i suddetti oggetti DAO si fa uso di metodi factory associati a classi specifiche.

//	______________________
//	|   CLASSI FACTORY   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Si usa un unica classe factory astratta per fornire specifiche per le factory concrete, espone inoltre un metodo creazionale per istanziare 
//  factory concrete.
//  Si sviluppa una factory concreta per ogni tipo di DB supportato nell'applicazione, queste factory concrete permettono di:
//  -   ottenere oggetti DAO appropriati al tipo di DB corrispondente
//  -   gestire l'ottenimento delle connessioni, autenticazioni, ecc.

//	_____________
//	|   TO DO   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Per sfruttare il pattern DAO quindi dovremo implementare:
//  -   1 factory astratta (DAOFactory.java)
//  -   1 factory concreta per ogni DB supportato (DB2DAOFactory.java,...)
//  -   1 oggetto DTO per ogni tipo di entità che si vuole trattare 
//  -   1 interfaccia DAO per ogni oggetto DTO che si vuole trattare
//  -   1 implementazione dell'interfaccia DAO di un DTO per ciascun DB supportato

//	_________________
//	|   LAZY LOAD   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  La politica di istanziamento del Lazy Load prevede che nel caso di istanziamento di un oggetto completo, ossia un oggetto 
//  che per essere istanziato causa l'interrogazione di più relazioni distinte sul DB correlate fra loro attraverso delle FOREIGN KEY, 
//  sia possibile frammentare il reperimento dei dati solo al momento dell'effettivo uso di quei dati.
//  Demandare ad operazioni diverse l'istanziamento di parti (di solito collezioni di elementi) dell'oggetto completo, 
//  alleggerisce il carico computazionale dell'operazione di Retrive.
//  Il Lazy Load viene implementato attraverso il Pattern Proxy, pensiamo ad una classe "MyClass1" (Tabella1 sul DB), caratterizzata al suo interno da 
//  una collezione di classi "MyClass2" (Tabella2 sul DB), per semplificare l'istanziazione dell'oggetto MyClass1 eviteremo di caricare anche tutta la collezione
//  di oggetti MyClass2, eseguiremo quel caricamento solo nel momento in cui viene invocato il metodo "MyClass1.getCollection()".
//  Per fare cio dovremo implementare una classe Proxy per "MyClass1", che viene restituita dalla classe DAO di MyClass1.
//  Un esempio può essere:
public class Cliente 
{
    private int codiceCliente;
    private List<Ordine> ordini;
    …
    public List<Ordine> getOrdini() 
    {
        return this.ordini;
    }
    ...
}
// Questa è la classe proxy
public class ClienteProxy extends Cliente 
{
    public List<Ordine> getOrdini() 
    {
        List<Ordine> listaOrdini = null;
        try 
        {
            OrdineDAO daoOrdine = new OrdineDAOImpl();
            listaOrdini = daoOrdine.doRetrieveByCliente(this.getCodice());
            this.setOrdini(listaOrdini);
        } 
        catch (PersistenceException e) 
        {
            throw new UnChechedPersistenceException(e.getMessage());
        }
        return listaOrdini;
    }
}
//  Nel caos è anche possibile implementare la classe Proxy con una forma di chaching che impedisce il caricamento miultiplo
public class ClienteProxy extends Cliente 
{
    private boolean caricato = false; //flag
    public List<Ordine> getOrdini() 
    {
        try 
        {
            if (!this.caricato) 
            {
                OrdineDAO dao = new OrdineDAOImpl();
                this.setOrdini(dao.doRetrieveByCliente(this.getCodice()));
                this.caricato = true;
            }
        } 
        catch (PersistenceException e) 
        {
            throw new UnChechedPersistenceException(e.getMessage());
        }
        return super.getOrdini();
    }
}
//  Possiamo sintetizzare il processo di ricostruzione degli
//  oggetti dal DB come segue:
//  -   In base ai casi d'uso (e a una stima della frequenza delle
//      corrispondenti operazioni) decidiamo quando conviene
//      seguire una strategia Lazy Load.
//  -   Per le classi con associazioni per le quali è stata scelta
//      la strategia Lazy Load applichiamo il pattern Proxy.
//  -   Per le classi con associazioni per le quali non conviene
//      applicare la strategia Lazy Load ricostruiamo la rete
//      (parziale) di oggetti con i risultati di un join.
//  In fase di progettazione conviene quindi arricchire il class
//  diagram con annotazioni sulle associazioni che indicano la
//  strategia di caricamento ("fetch") dei dati: pigro (Lazy Load)
//  vs. immediato (Eager).