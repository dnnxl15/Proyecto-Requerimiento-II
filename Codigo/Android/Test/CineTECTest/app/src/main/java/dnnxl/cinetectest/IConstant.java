package dnnxl.cinetectest;

public interface IConstant
{
    public final String USER_INTERFACE = "userInterface.fxml"; // User interface window.

    /**
     *  Database constants
     */
    public final String DATABASE_DRIVER = "com.mysql.jdbc.Driver";

    public final String DATABASE_URL = "jdbc:mysql://localhost:3306/testandroid";

    public final String USERNAME = "root";

    public final String PASSWORD = "";

    public final String QUOTA = "";

    public final String MAX_POOL = "250";

    public final String USER_MIN = "user";

    public final String PASSWORD_MIN = "password";

    public final String MAX_POOLED_STATEMENT = "MaxPooledStatements";

    public final String PROCEDURE_INSERT_HOTELIER = "{call insertHotelier(?,?,?,?,?,?,?,?,?)}";

    public final String PROCEDURE_INSERT_CLIENT = "{call insertClient(?,?,?,?,?,?,?,?,?,?,?)}";

    public final String REGISTER_COMPLETE = "Register complete";

    public final String REGISTER_SUCCESSFULL = "Registered successfully ";

    public final String ALL_FIELD_COMPLETE = "All the text field must be complete";

    public final String PASSWORD_DONT_MATCH = "Password's don't match";

    public final String USERNAME_EXIST = "Username exist";

    public final String ERROR = "Error ";

    public final String VALIDATE_NAME_AGENCY_QUERY =  "{? = call validateAgencyName(?)}";

    public final String INSERT_MODERATOR_QUERY = "{call insertModerator(?,?,?,?,?,?)}";

    public final String INSERT_AGENCY_QUERY = "{call insertAgency(?,?,?)}";

    public final String VALIDATE_NAME_MODERATOR_QUERY = "{? = call validateModeratorName(?)}";

    public final String WINDOW_REGISTER_HOTELIER = "registerHotelier.fxml";

    public final String WINDOW_REGISTER_CLIENT = "registerClient.fxml";

    public final String WINDOW_REGISTER_AGENCY = "registerAgency.fxml";

    public final String WINDOW_REGISTER_MODERATOR = "registerModerator.fxml";

    public final String GET_LOCATION_DATA_QUERY = "{call getLocation()}";

    public final String GET_SERVICES_NAME_QUERY = "{call getServices(?)}";

    public final String GET_INFO_HOTEL_QUERY = "{call getHotelInfo2()}";

    public final String GET_ALL_SERVICE_QUERY = "{call getAllService()}";

    public final String GET_ALL_SERVICE_ROOM = "{call getAllServiceRoom()}";

    public final String INSERT_COUNTRY_QUERY = "{call insertCountry(?)}";

    public final String INSERT_PROVINCE_QUERY = "{call insertProvince(?,?)}";

    public final String INSERT_CITY_QUERY = "{call insertCity(?,?)}";

    public final String INSERT_DISTRICT_QUERY = "{call insertDistrict(?,?)}";

    public final String GET_COUNTRY_QUERY = "{call getCountry()}";

    public final String GET_PROVINCE_QUERY = "{call getProvince()}";

    public final String GET_CITY_QUERY = "{call getCity()}";










}
