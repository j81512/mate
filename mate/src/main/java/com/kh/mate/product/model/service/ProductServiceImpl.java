package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.product.model.dao.ProductDAO;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO productDAO;
	//ch
	@Override
	public List<Product> selectProductListAll() {
		List<Product> list = productDAO.selectProductListAll();
		
		if(list != null) {
			for(Product p : list) {
				List<ProductImages> imgs =  productDAO.selectProductMainImages(p.getProductNo());
				p.setProductImages(imgs);
			}
		}
		return list;
	}
	
	@Override
	public List<Product> searchProductList(Map<String, Object> map) {
		
		List<Product> list = productDAO.searchProductList(map);
		
		if(list != null) {
			for(Product p : list) {
				List<ProductImages> imgs =  productDAO.selectProductMainImages(p.getProductNo());
				p.setProductImages(imgs);
			}
		}
		
		return list;
	}
	
	
	@Override
	public List<Product> productCategory(String category) {
		
		List<Product> list = productDAO.productCategory(category);
		if(list != null) {
			for(Product p : list) {
				List<ProductImages> imgs =  productDAO.selectProductMainImages(p.getProductNo());
				p.setProductImages(imgs);
			}
		}
		
		return list;
	}
	
	
	
	//jw
	@Override
	public int productEnroll(Product product) {
		
		int result = productDAO.productEnroll(product);
		
		//MainImages가 추가되어있다면 실행될 메소드
		if(product.getProductMainImages() != null) {
			for(ProductMainImages mainImg : product.getProductMainImages()) {
				
				mainImg.setProductNo(product.getProductNo());
				result = productDAO.mainImagesEnroll(mainImg);
			}
		}
		return result;
	}

	@Override
	public Product selectProductOne(String productNo) {
		return productDAO.selectProductOne(productNo);
	}
	
	

	
	
}
