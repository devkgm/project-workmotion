package com.workmotion.app.member;

import com.workmotion.app.department.DepartmentDTO;

public class MemberDTO{
	
	private Long id;
	private Long role_id;
	private Long company_id;
	private String email;
	private String password;
	private String name;
	private Long department_id;
	private Long phone;
	private Long position_id;
	private Avatar avatar;
	
	
	
	
	
	

	
	
	public Avatar getAvatar() {
		return avatar;
	}
	public void setAvatar(Avatar avatar) {
		this.avatar = avatar;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getRole_id() {
		return role_id;
	}
	public void setRole_id(Long role_id) {
		this.role_id = role_id;
	}
	public Long getCompany_id() {
		return company_id;
	}
	public void setCompany_id(Long company_id) {
		this.company_id = company_id;
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
	public Long getDepartment_id() {
		return department_id;
	}
	public void setDepartment_id(Long department_id) {
		this.department_id = department_id;
	}

	public Long getPhone() {
		return phone;
	}
	public void setPhone(Long phone) {
		this.phone = phone;
	}

	public Long getPosition_id() {
		return position_id;
	}
	public void setPosition_id(Long position_id) {
		this.position_id = position_id;
	}
	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", role_id=" + role_id + ", company_id=" + company_id + ", email=" + email
				+ ", password=" + password + ", name=" + name + ", department_id=" + department_id + ", phone=" + phone
				+ ", position_id=" + position_id + ", avatar=" + avatar + "]";

	}
	
	
	
}
