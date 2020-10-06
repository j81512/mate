package com.kh.mate.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Member {

	private String memberId;
	private String password;
	private String name;
	private String gender;
	private Date birthday;
	private String phone;
	private Date enrollDate;
	
}