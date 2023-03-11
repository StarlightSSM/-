package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	public static Connection getConnection() {
		try {
			// String dbURL = "jdbc:mysql://localhost:3306/USER";
			String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
		   //    String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
		   String dbID="root";
		   //String dbID="inhatc";
			String dbPassword="inha1958";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
