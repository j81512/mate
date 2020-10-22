package com.kh.mate.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.member.model.vo.Address;
import com.kh.mate.product.model.dao.ProductDAO;
import com.kh.mate.product.model.vo.Cart;
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
	public int insertCart(Map<String, Object> param) {
		return productDAO.insertCart(param);
	}

	@Override
	public List<Cart> selectCartList(String memberId) {
		
		List<Cart> cartList = productDAO.selectCartList(memberId);
		for(Cart c : cartList) {
			c.setSelectedProduct(productDAO.selectProductOne(String.valueOf(c.getProductNo())));
			c.getSelectedProduct().setPmiList(productDAO.selectProductMainImages(c.getProductNo()));
		}
		return cartList;
	}

	@Override
	public int deleteFromCart(Map<String, Object> param) {
		return productDAO.deleteFromCart(param);
	}

	@Override
	public List<Address> selectAddressList(String memberId) {
		return productDAO.selectAddressList(memberId);
	}

	
	//jh
	@Override
	public int insertReview(Map<String, Object> param) {
		return productDAO.insertReview(param);
	}

	@Override
	public int updatePurchaseConfirm(int purchaseLogNo) {
		return productDAO.updatePurchaseConfirm(purchaseLogNo);
	}

	@Override
	public int insertReturn(Map<String, Object> param) {
		
		int result = productDAO.insertReturn(param);
		if(result <= 0) return result;
		if(param.containsKey("originalFilename")) {
			int returnNo = productDAO.getReturnNo();
			param.put("returnNo", returnNo);
			result = productDAO.insertReturnImages(param);
		}
		return result;
	}
	
	
	

	
	
}
