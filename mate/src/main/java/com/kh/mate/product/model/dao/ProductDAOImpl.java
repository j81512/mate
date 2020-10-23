package com.kh.mate.product.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.common.paging.PagingVo;
import com.kh.mate.member.model.vo.Address;
import com.kh.mate.product.model.vo.Cart;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Autowired
	private SqlSessionTemplate session;

	//ch
	@Override
	public int countProduct() {
		return session.selectOne("product.countProduct");
	}
	
	
	@Override
	public List<Product> selectProductListAll(PagingVo page) {
		return session.selectList("product.selectProductListAll",page);
	}


	@Override
	public List<ProductMainImages> selectProductMainImages(int productNo) {
		return session.selectList("product.selectProductMainImages", productNo);
	}

	
	
	@Override
	public List<Product> searchProductList(Map<String, Object> map) {
		return session.selectList("product.searchProductList",map);
	}
	
	

	@Override
	public List<Product> productCategory(String category) {
		return session.selectList("product.productCategory",category);
	}

	//jw
	@Override
	public int productEnroll(Product product) {
		return session.insert("product.productEnroll", product);
	}

	@Override
	public int mainImagesEnroll(ProductMainImages mainImg) {
		return session.insert("product.mainImegesEnroll", mainImg);
	}

	@Override
	public Product selectProductOne(String productNo) {
		return session.selectOne("product.selectProductOne", productNo);
	}

	@Override
	public int productImageEnroll(ProductImages productImage) {
		return session.insert("product.productImageEnroll", productImage);
	}

	@Override
	public List<ProductMainImages> selectProductMainImages(String productNo) {
		return session.selectList("product.selectProductMainImages", productNo);
	}

	@Override
	public int insertCart(Map<String, Object> param) {
		return session.insert("product.insertCart", param);
	}

	@Override
	public List<Cart> selectCartList(String memberId) {
		return session.selectList("product.selectCartList", memberId);
	}

	
	//jh
	@Override
	public int insertReview(Map<String, Object> param) {
		return session.insert("product.insertReview", param);
	}

	@Override
	public int updatePurchaseConfirm(int purchaseLogNo) {
		return session.update("product.updatePurchaseConfirm", purchaseLogNo);
	}

	@Override
	public int insertReturn(Map<String, Object> param) {
		return session.insert("product.insertReturn", param);
	}

	@Override
	public int getReturnNo() {
		return session.selectOne("product.selectReturnNo");
	}

	@Override
	public int insertReturnImages(Map<String, Object> param) {
		return session.insert("product.insertReturnImages", param);
	}

	@Override
	public int deleteFromCart(Map<String, Object> param) {
		return session.delete("product.deleteFromCart", param);
	}

	@Override
	public List<Address> selectAddressList(String memberId) {
		return session.selectList("product.selectAddressList", memberId);
	}

	@Override
	public int insertPurchase(Map<String, Object> idAndAddr) {
		return session.insert("product.insertPurchase", idAndAddr);
	}

	@Override
	public int getPurchaseNo() {
		return session.selectOne("product.getPurchaseNo");
	}

	@Override
	public int insertPurchaseLog(Map<String, Object> param) {
		return session.insert("product.insertPurchaseLog", param);
	}
	

	
	
}
