import org.hibernate.*;
import org.hibernate.cfg.*;

public class HibernateUtil 
{
    private static SessionFactory sessionFactory = initHibernateUtil();

    private static SessionFactory initHibernateUtil()
    {
        try 
        {
            return new Configuration().configure().buildSessionFactory();
        } 
        catch (HibernateException ex) 
        {
            throw new ExceptionInInitializerError(ex); 
        }
    }

    public static SessionFactory getSessionFactory() 
    {
        return sessionFactory;
    }
    
    public static void shutdown() 
    {
        getSessionFactory().close(); //Close caches and connection pools
    } 
}