package com.kh.mate.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.mate.member.model.vo.Address;
import com.kh.mate.product.model.vo.Cart;
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

	int insertCart(Map<String, Object> param);

	List<Cart> selectCartList(String memberId);

	int deleteFromCart(Map<String, Object> param);

	List<Address> selectAddressList(String memberId);

	//jh
	int insertReview(Map<String, Object> param);

	int updatePurchaseConfirm(int purchaseLogNo);

	int insertReturn(Map<String, Object> param);

	int getReturnNo();

	int insertReturnImages(Map<String, Object> param);



}
