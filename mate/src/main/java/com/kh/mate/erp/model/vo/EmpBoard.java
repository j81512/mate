package com.kh.mate.erp.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class EmpBoard implements Serializable{

	private int boardNo;
	private String category;
	private String title;
	private String content;
	private String empId;
	private Date regDate;
	private int enabled;

}
