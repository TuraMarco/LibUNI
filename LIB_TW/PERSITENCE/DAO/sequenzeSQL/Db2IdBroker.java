import java.sql.PreparedStatement;

import javax.sql.DataSource;

public class IdBrokerDB2 implements IdBroker 
{
    static final String create_sequence =   "CREATE SEQUENCE sequenza_id" +
                                            "AS INTEGER" +
                                            "START WITH 1" +
                                            "INCREMENT BY 1" +
                                            "MINVALUE 0" +
                                            "MAXVALUE 9999999" +
                                            "NO CYCLE";

    static final String get_id = "SELECT(NEXTVAL FOR sequenza_id) INTO newId";

    public int newId() throws PersistenceException 
    {
        int newId = -1;
        DataSource ds = new DataSource();
        ResultSet result = null;
        PreparedStatement statement = null;
        Connection connection = null;

        try 
        {
            connection = ds.getConnection();
            statement = connection.prepareStatement(get_id);
            result = statement.executeQuery();
            if (result.next()) 
            {
                newId = result.getInt("newId");
            }
            else
            {
                throw new PersistenceException("invalid id");
            }
        } 
        catch(SQLException e) 
        {
            throw new PersistenceException(e.getMessage());
        }
        finally 
        {
            try 
            {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } 
            catch (SQLException e) 
            {
                throw new PersistenceException(e.getMessage());
            }
        }
        return newId;
    }

    public boolean createSequence() throws PersistenceException
    {
        boolean result = false;
        DataSource ds = new DataSource();
        PreparedStatement statement = null;
        Connection connection = null;

        try
        {
            ds.getConnection();
            statement.execute(create_sequence);
            result = true;
        }
        catch(SQLException e)
        {
            throw new PersistenceException(e.getMessage());
        }
        finally 
        {
            try 
            {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } 
            catch (SQLException e) 
            {
                throw new PersistenceException(e.getMessage());
            }
        }
        return result;
    }
}