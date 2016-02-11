import java.util.HashMap;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.json.simple.parser.JSONParser;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectionManager
{
    private static Connection connection = null;


    public static Connection open() throws IOException, ParseException, SQLException
    {
    	String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_bmclaren";
		String uid = "bmclaren";
		String pw = "56301147";

		System.out.println("Connecting to database.");
		try {
			connection = DriverManager.getConnection(url, uid, pw);

		} catch (Exception e) {
			System.out.println("Log into UBC VPN");
		}
		// Note: Must assign connection to instance variable as well as
		// returning it back to the caller
		// TODO: Make a connection to the database and store connection in con
		// variable before returning it.
		return connection;
    }

    public static void close() throws SQLException
    {
    	System.out.println("Disconnecting from database.");

        if (connection != null)
        {
            connection.close();
        }

        connection = null;
    }

}
