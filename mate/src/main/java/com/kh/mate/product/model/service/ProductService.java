package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.mate.member.model.vo.Address;
import com.kh.mate.member.model.vo.Member;
import com.kh.mate.product.model.vo.Cart;
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

	int insertCart(Map<String, Object> param);

	List<Cart> selectCartList(String memberId);

	int deleteFromCart(Map<String, Object> param);

	List<Address> selectAddressList(String memberId);



	
	//jh
	int insertReview(Map<String, Object> param);

	int updatePurchaseConfirm(int purchaseLogNo);

	int insertReturn(Map<String, Object> param);

	int purchaseProducts(List<Map<String, Object>> params);


}
