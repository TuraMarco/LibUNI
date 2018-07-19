import java.util.*;
import org.hibernate.*;
import persistence.HibernateUtil;

public class Bid 
{
    public static void main(String[] args) 
    {
        //First unit of work: Istanzio un oggetto User e lo rendo PERSISITENT
        /**
         *  Equivale a:
                insert into UTENTE (USERNAME,NOME,COGNOME, COD_FIS,PASSWORD,EMAIL,VIA,CIVICO,CAP,CITTA);
                values ('pippo', null, null, null, null, null, null, null, null, null);
        */
        Session session = HibernateUtil.getSessionFactory().openSession();  // Apro una sessione di comunicazione tra l'applicazione ed il DB
        Transaction tx = session.beginTransaction();                        // Inizio una transazione (imposto l'autocommit a false)
        User user = new User("pippo");                                      // Istanzio un oggetto di tipo User, in questo momento è TRANSIENT
        String userId = (String) session.save(user);                        // Rendo l'istanza PERSISITENT, e ottengo la stringa ID di quella istanza
        tx.commit();                                                        // concludo la transazione
        session.close();                                                    // chiudo la sessione e rendo l'oggetto DETACHED

        //Second unit of work: Carico una oggetto a partire dal suo identificatore
        /**
         *  Equivale a:
                update UTENTE set ('pippo', 'filippo', null, null, null, null, null, null, null, null) where USER.username = 'pippo';
        */
        session = HibernateUtil.getSessionFactory().openSession();          // Apro una sessione di comunicazione tra l'applicazione ed il DB
        tx = session.beginTransaction();                                    // Inizio una transazione (imposto l'autocommit a false)
        user = (User) session.get(User.class,userId);                       // Istanzio un oggetto PERSISITENT di tipo User a partire da il suo ID (se non esiste istanza ritorna NULL)
        user.setNome("Filippo");
        tx.commit();                                                        // concludo la transazione (accorgendosi da solo che l'istnaza è cambiata attraverso un dirty checking)
        session.close();                                                    // chiudo la sessione e rendo l'oggetto DETACHED

        //Third unit of work: Eseguo query arbitrarie
        /**
         *  Questo tipo di accesso deve essere limitato a quei casi in cui 
         *  è necessario effettuare una ricerca sul DB non di tipo diretto,
         *  quindi del tipo: FindByCriteria()
         *  Nell'esempio la query è equivalente a:
         *      select * from UTENTE order by username
        */
        session = HibernateUtil.getSessionFactory().openSession();          // Apro una sessione di comunicazione tra l'applicazione ed il DB
        tx = session.beginTransaction();                                    // Inizio una transazione (imposto l'autocommit a false)
        List<User> users = session.createSQLQuery("select * from UTENTE order" +
            "by username").addEntity(User.class).list();                    // Istanzio una collezione di utenti
        System.out.println(users.size()+" user(s) found: ");
        for (User u : users) 
        {
            System.out.println (u.getNome()); 
        }
        tx.commit();                                                        // Concludo la transazione
        session.close();                                                    // Chiudo la sessione e rendo l'oggetto DETACHED
        HibernateUtil.shutdown();                                           // Spengo l'applicazione
    } 
}

/**
 * Per inizializzare Hibernate si costruisce un oggetto SessionFactory a partire da un oggetto Configuration,
 * che rappresenta il file di configurazione di Hibernate: hibernate.cfg.xml
 * 
 *      SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
 * 
 * alla chiamata di "new Configuration()" viene cercato un file "hibernate.configuration" e tutte le impostazioni
 * definite sono associate all'oggetto "Configuration".
 * Quando "configure()" è invocato, hibernate cerca il file "hibernate.cfg.xml" e ne carpisce le info di inizializzazione.
 * Nella maggior parte dei casi "SessionFactori" deve essere istanziata una sola volta durante la fase di inizializzazione di
 * Hibernate, e gioca il ruolo di gestore delle istanze di "Session".
 * E'quindi buona prassi creare una classe "HibernateUtile" che inizializzi la persistenza istanziando una "SessionFactory" come 
 * singleton
*/