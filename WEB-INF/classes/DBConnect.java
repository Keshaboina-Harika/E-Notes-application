
import java.sql.*;

public class DBConnect {
  private static Connection con;
  public static Connection getConn() {
	  try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/enotes","root","Raviteja@9553");
		System.out.println("connected");		  		  
	  } catch (Exception e) {
		  e.printStackTrace();
	}
	  return con;
  } 
 
}