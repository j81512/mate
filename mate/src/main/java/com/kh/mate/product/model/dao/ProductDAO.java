package com.kh.mate.product.model.dao;

import java.util.List;

import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;

public interface ProductDAO {

	//jw
	List<Product> selectProductListAll();

	List<ProductImages> selectProductMainImages(int productNo);

	
	//ch
	int productEnroll(Product product);

}
