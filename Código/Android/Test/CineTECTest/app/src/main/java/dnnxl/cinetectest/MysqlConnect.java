package dnnxl.cinetectest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;



public class MysqlConnect implements IConstant
{
    private String DatabaseDriver;
    private String DatabaseUrl;
    private String Username;
    private String Password;
    private String MaxPool;
    private Connection connection;
    private static MysqlConnect instance = null;

    /**
     * Method constructor
     */
    private MysqlConnect()
    {
        DatabaseDriver = IConstant.DATABASE_DRIVER;
        DatabaseUrl = IConstant.DATABASE_URL;
        Username = IConstant.USERNAME;
        Password = IConstant.PASSWORD;
        MaxPool = IConstant.MAX_POOL;
    }

    /**
     * Method to get the instance
     * Author: Danny Xie Li
     * Description: The next method is use to get the instance of the object MysqlConnect.
     * Last modification: 28/10/17
     */
    public static MysqlConnect getInstance() throws Exception
    {
        if(instance == null)
        {
            instance = new MysqlConnect();
        }
        return instance;
    }

    /**
     * Method to connect the database
     * Author: Danny Xie Li
     * Description: The next method get connection to the database and return a object connection.
     * Last modification: 28/10/17
     */
    public Connection connect()
    {
        if (connection == null)
        {
            try
            {
                Class.forName(DatabaseDriver);
                connection = DriverManager.getConnection(DatabaseUrl, Username, Password);
            }
            catch (ClassNotFoundException | SQLException e)
            {
                e.printStackTrace();
            }
        }
        return connection;
    }

    /**
     * Method to disconnect the database
     * Author: Danny Xie Li
     * Description: The next method disconnect the database.
     * Last modification: 28/10/17
     */
    public void disconnect()
    {
        if (connection != null)
        {
            try
            {
                connection.close();
                connection = null;
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
    }
}