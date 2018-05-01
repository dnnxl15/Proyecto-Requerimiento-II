package dnnxl.cinetectest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Answer implements IConstant {
    private static Answer instance = null;
    private MysqlConnect objectQuery;
    private Connection objectConnection;

    /**
     * Method constructor
     *
     * @throws Exception
     */
    private Answer() throws Exception {
        objectQuery = MysqlConnect.getInstance();
        objectConnection = objectQuery.connect();
    }

    /**
     * Instance
     *
     * @return
     * @throws Exception
     */
    public static Answer getInstance() throws Exception {
        if (instance == null) {
            instance = new Answer();
        }
        return instance;
    }

    /**
     * Method get location of the hotel
     * Author: Danny Xie Li
     * Description: The next method return an arraylist of objects that conteins all the data about the location of the hotel.
     * Last modification: 1/11/17
     */
    public void addLikeComment(String pHotel, String pPerson) throws SQLException
    {
        CallableStatement callStatement = objectConnection.prepareCall("{call insertUser (?,?)}");
        callStatement.setString(1, pHotel);
        callStatement.setString(2, pPerson);
        callStatement.execute();
    }
}