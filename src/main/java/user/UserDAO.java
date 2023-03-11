package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {

	public static UserDAO instance = null;

	// 멤버 변수
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		try {
			// String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
			// String dbURL = "jdbc:mysql://34.64.82.240:3306/USER?serverTimezone=Asia/Seoul";
			// String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
			String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
		    //String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
		   String dbID="root";
		   //String dbID="inhatc";
			String dbPassword = "inha1958";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static UserDAO getInstance() {
		if (instance == null) {
			instance = new UserDAO();
		}
		return instance;
	}

	// login 메서드
	public int login(String email, String password) {
		String SQL = "SELECT pw FROM user WHERE EMAIL=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(password)) {
					return 1;// 로그인성공
				} else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	// 회원정보를 조회하는 메서드
	public UserDTO getUser(String email) {
		UserDTO dto = null;

		String sql = "select * from user where email = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new UserDTO();

				dto.setEmail(email);
				dto.setPassword(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setBirth(rs.getString("birth"));
				dto.setW_intro(rs.getString("w_intro"));
				dto.setU_img(rs.getString("u_img"));
				dto.setU_imgReal(rs.getString("u_imgReal"));

				return dto;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("return: -1");
		return null;
	}

	// update 메서드
	public int update(String password, String name, String birth, String email) {
		String sql = "update user set pw = ?, name = ?, birth = ? where email = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, name);
			pstmt.setString(3, birth);
			pstmt.setString(4, email);
			pstmt.executeUpdate();
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// update 메서드
	public int updateProfile(String name, String phone, String w_intro, String email) {
		String sql = "update user set name = ?, phone = ?, w_intro = ? where email = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setString(3, w_intro);
			pstmt.setString(4, email);
			System.out.println(name);
			pstmt.executeUpdate();
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	
	// update 메서드
		public int updateU_img(String u_img, String u_imgReal, String email) {
			String sql = "update user set u_img = ?, u_imgReal = ? where email = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_img);
				pstmt.setString(2, u_imgReal);
				pstmt.setString(3, email);
				System.out.println(email);
				pstmt.executeUpdate();
				return 0;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
	// delete 메서드
	public int delete(String email) {
		String sql = "delete from user where email = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	 /*프로필이미지 부분*/
	   public int Profile(String email, String userProfile) {
	      Connection conn=null;
	      PreparedStatement pstmt =null;
	      String sql = "update user set userProfile = ? where email = ?";
	      try {
	         conn = DriverManager.getConnection("jdbc:mysql://localhost/USER", "root", "202144097!");
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userProfile);
	         pstmt.setString(2, email);
	         return pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         try {
	            if(pstmt!=null)pstmt.close();
	            if(conn!=null)conn.close();
	         }catch (Exception e) {
	            e.printStackTrace();
	      }
	   }
	      return -1;
	   
	   }

}
