package com.kh.mate.product.model.vo;

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
public class Product {

	private int productNo;
	private String empId;
	private String productName;
	private int stock;
	private Date regDate;
	private String category;
	private String brand;
	private String title;
	private String content;
	private int price;
	private int enabled;
	
}
