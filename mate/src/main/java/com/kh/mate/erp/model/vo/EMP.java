package com.kh.mate.erp.model.vo;

import java.io.Serializable;
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
public class EMP implements Serializable{

	private String empId;
	private String empPwd;
	private String empName;
	private String empAddress;
	private String empPhone;
	private Date empEnrollDate;
	private int empStatus;
	
}
