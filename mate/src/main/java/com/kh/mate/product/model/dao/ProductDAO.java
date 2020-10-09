package com.kh.mate.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;

public interface ProductDAO {

	//ch
	List<Product> selectProductListAll();

	List<ProductImages> selectProductMainImages(int productNo);

	List<Product> searchProductList(Map<String, Object> map);
	
	List<Product> productCategory(String category);
	
	//jw
	int productEnroll(Product product);



}
