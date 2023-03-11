// 회원가입에 필요한 클래스 파일
package user;

// util 부분이 잘 작동안되는 것 같아 없애버림
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Sign_upDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
	// private String dbURL = "jdbc:mysql://34.64.82.240:3306/USER?serverTimezone=Asia/Seoul";
	// String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
    //private String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
	private String dbID="root";
    //private String dbID="inhatc";
	private String dbPassword = "inha1958"; // 자신의 pw로 맞춰서 바꾸기
	
	// String email, String pw, String name, String phone, String w_intro, String u_img, String birth => join 매개변수에다 이걸로 고치기
	public int join(String email, String pw, String name, String phone, String birth, String w_intro, String u_img, String u_imgReal) {
		// values(?,?,?,?,?,?,?) 이걸로 고치기(물음표 8개 -> 7개)
		String SQL = "insert into user values(?,?,?,?,?,?,?,?)";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			DriverManager.getConnection(dbURL, dbID, dbPassword);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, phone);
			pstmt.setString(5,  birth);
			pstmt.setString(6, w_intro);
			pstmt.setString(7, u_img);
			pstmt.setString(8,  u_imgReal);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}