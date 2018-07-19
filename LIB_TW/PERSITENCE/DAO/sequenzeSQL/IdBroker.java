public interface IdBroker
{
    public int newId() throws PersistenceException;
    public boolean createSequence() throws PersistenceException;
}