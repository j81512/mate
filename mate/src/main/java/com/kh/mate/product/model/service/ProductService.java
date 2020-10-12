package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;

public interface ProductService {
	//ch
	List<Product> selectProductListAll();

	List<Product> productCategory(String category);
	
	//jw
	int productEnroll(Product product);


	List<Product> searchProductList(Map<String, Object> map);

	Product selectProductOne(String productNo);

	int productImageEnroll(ProductImages productImage);





}
