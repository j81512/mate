package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.mate.product.model.vo.Product;

public interface ProductService {
	//ch
	List<Product> selectProductListAll();

	List<Product> productCategory(String category);
	
	//jw
	int productEnroll(Product product);


	List<Product> searchProductList(Map<String, Object> map);





}
