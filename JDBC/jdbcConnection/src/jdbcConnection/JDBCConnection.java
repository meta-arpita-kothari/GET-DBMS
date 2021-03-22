package jdbcConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * Class containing method to get connection for mySQL database
 * 
 */
public class JDBCConnection {
	private static Connection connection;
	
	/**
	 * method to load drivers and return the connection object
	 * @return Connection class object
	 */
	public static Connection getDatabaseConnection (String databaseName,String username,String password) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+databaseName,username,password);
		} catch(ClassNotFoundException cne) {
			System.out.println("Driver not found ! Exception in generating Connection.");
		} catch(SQLException se) {
			System.out.println("SQL Exception ! Exception in generating Connection.");
		}
		return connection;
	}
}