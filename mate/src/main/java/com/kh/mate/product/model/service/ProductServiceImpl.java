package com.kh.mate.product.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.product.model.dao.ProductDAO;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO productDAO;
	//jw
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
	
	//ch

	@Override
	public int productEnroll(Product product) {
		
		int result = productDAO.productEnroll(product);
		
		return 0;
	}
	
	

	
	
}
