package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.product.model.dao.ProductDAO;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO productDAO;
	//ch
	@Override
	public List<Product> selectProductListAll() {
		List<Product> list = productDAO.selectProductListAll();
		
		if(list != null) {
			for(Product p : list) {
				List<ProductMainImages> imgs =  productDAO.selectProductMainImages(p.getProductNo());
				p.setPmiList(imgs);
			}
		}
		return list;
	}
	
	@Override
	public List<Product> searchProductList(Map<String, Object> map) {
		
		List<Product> list = productDAO.searchProductList(map);
		
		if(list != null) {
			for(Product p : list) {
				List<ProductMainImages> imgs =  productDAO.selectProductMainImages(p.getProductNo());
				p.setPmiList(imgs);
			}
		}
		
		return list;
	}
	
	
	@Override
	public List<Product> productCategory(String category) {
		
		List<Product> list = productDAO.productCategory(category);
		if(list != null) {
			for(Product p : list) {
				List<ProductMainImages> imgs =  productDAO.selectProductMainImages(p.getProductNo());
				p.setPmiList(imgs);
			}
		}
		
		return list;
	}
	
	
	
	//jw

	@Override
	public Product selectProductOne(String productNo) {
		Product product = productDAO.selectProductOne(productNo);
		return productDAO.selectProductOne(productNo);
	}

	@Override
	public int productImageEnroll(ProductImages productImage) {
		return productDAO.productImageEnroll(productImage);
	}

	@Override
	public List<ProductMainImages> selectProductMainImages(String productNo) {
		return productDAO.selectProductMainImages(productNo);
	}

	@Override
	public List<Map<String, Object>> selectProductListMap() {
		return productDAO.selectProductListMap();
	}

	@Override
	public int insertCart(Map<String, Object> param) {
		return productDAO.insertCart(param);
	}

	@Override
	public List<Map<String, Object>> selectCartList(String memberId) {
		return productDAO.selectCartList(memberId);
	}
	
	
	

	
	
}
