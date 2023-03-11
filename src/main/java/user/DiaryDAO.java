package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class DiaryDAO {

	private Connection conn;
	private ResultSet rs;
	private PreparedStatement pstmt;

	public DiaryDAO() {
		try {
			// String dbURL = "jdbc:mysql://localhost:3306/user?serverTimezone=Asia/Seoul";
			// String dbURL = "jdbc:mysql://34.64.82.240:3306/USER?serverTimezone=Asia/Seoul";
			String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
		    //   String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
		   String dbID="root";
		   //String dbID="inhatc";
			String dbPassword = "inha1958";
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 일기정보를 조회하는 메서드
	public DiaryDTO getDiary(String w_id) {
		String sql = "select * from writing where w_id = ?";
		DiaryDTO diaryDTO = new DiaryDTO();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, w_id);
			
			UserDTO dto = null;
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new UserDTO();
				diaryDTO.setEmail(rs.getString("email"));
				diaryDTO.setW_id(rs.getString("w_id"));
				diaryDTO.setW_day(rs.getString("w_day"));
				diaryDTO.setW_title(rs.getString("w_title"));
				diaryDTO.setW_emotion(rs.getString("w_emotion"));
				diaryDTO.setW_img(rs.getString("w_img"));
				diaryDTO.setW_content(rs.getString("w_content"));
				
				return diaryDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 일기정보를 조회하는 메서드
	public int getDiary_Email(String email) {
		int count = 0;
		DiaryDTO dto = null;

		String sql = "select count(*) from writing where email = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new DiaryDTO();
				count = rs.getInt(1);
				dto.setEmail(rs.getString(dto.getEmail()));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("return: -1");
		return count;
	}
	
	// 회원이메일를 조회하는 메서드
	public String getEmail(String email) {
		String result = null;
		DiaryDTO dto = null;

		String sql = "select * from writing where email = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new DiaryDTO();
				dto.setEmail(rs.getString(dto.getEmail()));
			}
			result = dto.getEmail();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("return: -1");
		return result;
	}
	
	// 일기 작성에서 date 값 가져오기 메소드
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	// 작성된 일기 id 값 가져오기 메소드
	public int getNext() {
		String SQL = "SELECT w_id FROM writing ORDER BY w_id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public UserDTO getUser(String email) {
		UserDTO dto = null;

		String sql = "select * from user where email = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 일기 작성 메소드
	public int write(String email, String w_id, String w_day, String w_title, String w_emotion, String w_img,
			String w_content) {
		String sql = "insert into writing values(?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, getDate());
			pstmt.setString(4, w_title); // null
			pstmt.setString(5, w_emotion); // null
			pstmt.setString(6, w_img); // null
			pstmt.setString(7, w_content); // null
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	// 일기 수정 메소드
	public int update(String email, String w_id, String w_day, String w_title, String w_emotion, String w_img,
			String w_content) {
		String SQL = "update writing SET email = ?, w_day = ?, w_title = ?, w_emotion = ?, w_img = ? WHERE w_id =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, getDate());
			pstmt.setString(4, w_title);
			pstmt.setString(5, w_emotion);
			pstmt.setString(6, w_img);
			pstmt.setString(7, w_content);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 일기 삭제 메소드
	public int delete(int diaryID) {
		String SQL = "delete writing WHERE w_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, diaryID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 작성한 일기 선택 메소드
	public boolean select(String w_id) {
		String sql = "select * from writing where w_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, w_id);// ?�씤�뜳�뒪 �젙�쓽
			rs = pstmt.executeQuery();// DB�뿰�룞�빐�꽌 SQL臾� �떎�뻾
			return rs.next();// 媛믪씠 �엳�쑝硫� true �뾾�쑝硫� false;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// 일기 목록 메소드
	public ArrayList<DiaryDTO> getList(int pageNumber) {
		String sql = "select * from writing where w_id < ?";
		ArrayList<DiaryDTO> list = new ArrayList<DiaryDTO>();
		try {
			UserDTO dto = null;

			dto = new UserDTO();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				DiaryDTO diaryDTO = new DiaryDTO();
				diaryDTO.setEmail(rs.getString(1));
				diaryDTO.setW_id(rs.getString(2));
				diaryDTO.setW_day(rs.getString(3));
				diaryDTO.setW_title(rs.getString(4));
				diaryDTO.setW_emotion(rs.getString(5));
				diaryDTO.setW_img(rs.getString(6));
				diaryDTO.setW_content(rs.getString(7));
				list.add(diaryDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		String sql = "select * from writing where email = ? and w_id < ?";
		try {
			UserDTO dto = null;

			dto = new UserDTO();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			pstmt.setInt(2, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public ResultSet RSselect(String w_id) {
		String sql = "select * from writing where w_id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, w_id);// ?�씤�뜳�뒪 �젙�쓽
			rs = pstmt.executeQuery();// DB�뿰�룞�빐�꽌 SQL臾� �떎�뻾

			return rs;// 媛믪씠 �엳�쑝硫� true �뾾�쑝硫� false;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

}
