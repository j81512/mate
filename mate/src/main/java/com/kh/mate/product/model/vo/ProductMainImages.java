package com.kh.mate.product.model.vo;

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
public class ProductMainImages {

	private int productImageNo;
	private String originalFilename;
	private String renamedFilename;
	private int productNo;
}