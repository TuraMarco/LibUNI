//	_____________________
//	|   SESSION BEAN    |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Usati principalmente per la realizzazione di controller nel pattern MVC,
//  non sono persisitenti, quindi vengono persi in caso di feilure del server EJB e
//  non rappresentano dati salvti su di un DB, anche se possono accedervi e modificare i dati in esso contenuto
//  Il loro utilizzo principe è quello di modellare oggetti di processo o di controllo specifici per un particolare cliente,
//  per modellare workflow o attività di gestione e coordinamento di interazioni tra bean.
//  In breve sono finalizzati allo spostamento della LOGICA APPLICATIVA DI BUSINESS dal lato cliente a quello servitore.
//  In EJB2.x classe Bean deve implementare interfaccia
//      javax.ejb.SessionBean 
//  in EJB3.x solo uso di annotazioni
//  VI sono 2 diverse implementazioni dell'interfaccia SessionBean:
//  -   Stateless:  Esegue una richiesta e restituisce un risultato senza salvare alcuna informazionedi stato relativa al cliente,
//                  hanno quindi utilita nel caso servano per implementare elementi transienti o elementi temporanei di businness
//                  logic necessari ad uno specifico cliente, per un limitato intervallo di tempo.
//                  In EJB 3.0 i session bean di tipo stateless sono POJO annotati con "@Stateless"

// @Stateless
// public class PayrollBean implements Payroll
public class PayrollBean implements javax.ejb.SessionBean 
{
    SessionContext ctx;
    public void setSessionContext(SessionContext ctx) 
    {
     this.ctx = ctx;
    }
    public void ejbCreate() {}
    public void ejbActivate() {}
    public void ejbPassivate() {}
    public void ejbRemove() {}
    public void setTaxDeductions(int empId, int deductions) 
    {
        //...
    } 
}

//  -   Stateful:   Possono mantenere stato specifico per un cliente.
//                  In EJB 3.0 i session bean di tipo statefull sono POJO annotati con "@Stateful"

//	____________________
//	|   ENTITY BEAN    |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Forniscono una vista ad oggetti dei dati mantenuti in un database, sono caratterizzati da:
//  -   tempo di vita non connesso alla durata dell'interazione con i clienti
//  -   permanenza nel sistema sino a quando i dati esistono nel DB (long lived)
//  -   tipicmanete componenti sincronizzate con DB relazionali
//  FOrti di queste caratterisitiche hanno la possibilità di fornire un accesso condiviso per clienti differenti
//  In EJB2.x classe Bean deve implementare interfaccia
//      javax.ejb.EntityBean
//  in EJB3.x solo uso di annotazioni "@Entity"

//	____________________________
//	|   MESSAGE-DRIVEN BEAN    |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Hanno il ruolo di consumatori di messaggi asincroni, non possono essere invocati direttamente 
//  dai clienti ma vengono  attivati osloe ed esclusivamente in seguito all'arrivo di un messaggio. 
//  I clienti possono interagire con MDB tramite l'invio di messaggi verso le code o i topic per i 
//  quali questi componenti sono in ascolto (listener).
//  Hanno la caratteristicha di essere privi di stato. 
//  Nel caso di utilizzo delle librerie JMS il MDB corrispondente deve poter implementare l'interfaccia
//      javax.jms.MessageListener
//  Limplementazione del metodo "MessageListener.onMessage()" deve contenere la business logic.
//  In EJB 3.0 i Message Driven Bean sono POJO annotati con "@MessageDriven"