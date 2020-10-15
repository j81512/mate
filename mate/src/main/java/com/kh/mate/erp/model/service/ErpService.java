package com.kh.mate.erp.model.service;

import java.util.List;

import java.util.Map;


import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductMainImages;

public interface ErpService {

	int insertEmp(EMP emp);

	EMP selectOneEmp(String empId);

	List<Product> searchInfo(Map<String, Object> map);

	List<EMP> empList(EMP emp);

	Product orderProduct(Map<String, Object> map);

	int productEnroll(Product product);

	Product selectProductOne(String productNo);

	List<ProductMainImages> selectProductMainImages(String productNo);

	int productUpdate(Product product);




}
