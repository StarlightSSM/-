// ȸ�����Կ� �ʿ��� Ŭ���� ����
package user;

// util �κ��� �� �۵��ȵǴ� �� ���� ���ֹ���
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
	private String dbPassword = "inha1958"; // �ڽ��� pw�� ���缭 �ٲٱ�
	
	// String email, String pw, String name, String phone, String w_intro, String u_img, String birth => join �Ű��������� �̰ɷ� ��ġ��
	public int join(String email, String pw, String name, String phone, String birth, String w_intro, String u_img, String u_imgReal) {
		// values(?,?,?,?,?,?,?) �̰ɷ� ��ġ��(����ǥ 8�� -> 7��)
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