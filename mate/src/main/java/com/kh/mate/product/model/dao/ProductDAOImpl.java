package com.kh.mate.product.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Autowired
	private SqlSessionTemplate session;

	//ch
	@Override
	public List<Product> selectProductListAll() {
		return session.selectList("product.selectProductListAll");
	}

	@Override
	public List<ProductImages> selectProductMainImages(int productNo) {
		return session.selectList("product.selectProductMainImages", productNo);
	}

	
	
	@Override
	public List<Product> searchProductList(Map<String, Object> map) {
		return session.selectList("product.searchProductList",map);
	}

	//jw
	@Override
	public int productEnroll(Product product) {
		// TODO Auto-generated method stub
		return session.insert("product.productEnroll",product);
	}
	
	
	
	
}
