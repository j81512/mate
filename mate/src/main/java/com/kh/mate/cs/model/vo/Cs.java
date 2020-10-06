package com.kh.mate.cs.model.vo;

import java.io.Serializable;
import java.util.Date;

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
public class Cs implements Serializable {

	private int csno;
	private String title;
	private String content;
	private String memberId;
	private Date regdate;
	private String secret[];
	private String notice[];
}
