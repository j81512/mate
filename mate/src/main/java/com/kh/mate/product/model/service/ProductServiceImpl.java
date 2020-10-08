package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.product.model.dao.ProductDAO;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;

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
	
	
	
	//jw

	@Override
	public int productEnroll(Product product) {
		
		int result = productDAO.productEnroll(product);
		
		return 0;
	}
	
	

	
	
}
