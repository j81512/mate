package com.kh.mate.product.model.service;

import java.util.List;

import com.kh.mate.product.model.vo.Product;

public interface ProductService {
	//jw
	List<Product> selectProductListAll();

	
	//ch
	int productEnroll(Product product);

}
