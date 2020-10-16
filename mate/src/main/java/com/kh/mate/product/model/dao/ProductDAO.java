package com.kh.mate.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

public interface ProductDAO {

	//ch
	List<Product> selectProductListAll();

	List<ProductMainImages> selectProductMainImages(int productNo);

	List<Product> searchProductList(Map<String, Object> map);
	
	List<Product> productCategory(String category);
	
	//jw
	int productEnroll(Product product);

	int mainImagesEnroll(ProductMainImages mainImg);

	Product selectProductOne(String productNo);

	int productImageEnroll(ProductImages productImage);

	List<ProductMainImages> selectProductMainImages(String productNo);

	List<Map<String, Object>> selectProductListMap();



}
