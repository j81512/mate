package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

public interface ProductService {
	//ch
	List<Product> selectProductListAll();

	List<Product> productCategory(String category);
	
	//jw

	List<Product> searchProductList(Map<String, Object> map);

	Product selectProductOne(String productNo);

	int productImageEnroll(ProductImages productImage);

	List<ProductMainImages> selectProductMainImages(String productNo);

	List<Map<String, Object>> selectProductListMap();

	int insertCart(Map<String, Object> param);





}
