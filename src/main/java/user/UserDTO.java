package user;

public class UserDTO {
	private String email;
	private String password;
	private String name;
	private String phone;
	private String birth;
	private String w_intro;
	private String u_img;
	private String u_imgReal;
	
	public UserDTO() {
	}
	
	public UserDTO(String email, String password, String name, String phone, String birth, String w_intro, String u_img, String u_imgReal) {
		super();
		this.email = email;
		this.password = password;
		this.name= name;
		this.phone = phone;
		this.birth = birth;
		this.setW_intro(w_intro);
		this.u_img = u_img;
		this.u_imgReal = u_imgReal;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getW_intro() {
		return w_intro;
	}

	public void setW_intro(String w_intro) {
		this.w_intro = w_intro;
	}

	public String getU_img() {
		return u_img;
	}

	public void setU_img(String u_img) {
		this.u_img = u_img;
	}

	public String getU_imgReal() {
		return u_imgReal;
	}

	public void setU_imgReal(String u_imgReal) {
		this.u_imgReal = u_imgReal;
	}
	
}
