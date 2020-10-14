package com.kh.mate.erp.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.erp.model.dao.ErpDAO;
import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ErpServiceImpl implements ErpService {

	@Autowired
	private ErpDAO erpDAO;

	@Override
	public int insertEmp(EMP emp) {
		return erpDAO.insertEmp(emp);
	}

	@Override
	public EMP selectOneEmp(String empId) {
		return erpDAO.selectOneEmp(empId);
	}

	@Override
	public List<Product> searchInfo(Map<String, Object> map) {
		return erpDAO.searchInfo(map);
	}
	
	@Override
	public List<EMP> empList() {
		return erpDAO.empList();
	}

	@Override
	public Product orderProduct(Map<String, Object> map) {
		return erpDAO.orderProduct(map);
	}
	
	//김종완
	
	@Override
	public int productEnroll(Product product) {
		
		int result = erpDAO.productEnroll(product);
		
		//ImagesName도 추가
		if(product.getProductImagesName() != null) {
			List<String> imagesName = product.getProductImagesName();
			String str = "";
			for(int i = 0; i < imagesName.size(); i++) {
				str += imagesName.get(i);
				if(i != (imagesName.size() - 1)) {
					str += ",";
				}
			}
			log.debug("str = {}", str);
			
		ProductImages pigs = new ProductImages(0, str, product.getProductNo());
		result = erpDAO.productImageEnroll(pigs);
		}
		
		return result;
	}

	@Override
	public Product selectProductOne(String productNo) {
		return erpDAO.selectProductOne(productNo);
	}

	@Override
	public List<ProductMainImages> selectProductMainImages(String productNo) {
		return erpDAO.selectProductMainImages(productNo);
	}

	
	
	
	
	
}
