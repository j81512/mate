package com.kh.mate.erp.model.dao;

import java.util.List;

import java.util.Map;


import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.erp.model.vo.EmpBoard;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

public interface ErpDAO {

	int insertEmp(EMP emp);

	EMP selectOneEmp(String empId);

	List<Product> searchInfo(Map<String, Object> map);

	List<EMP> empList();

	Product orderProduct(Map<String, Object> map);

	int productEnroll(Product product);

	int productImageEnroll(ProductImages pigs);

	Product selectProductOne(String productNo);

	List<ProductMainImages> selectProductMainImages(String productNo);


	int productMainImagesEnroll(ProductMainImages mainImg);

	int productUpdate(Product product);

	int productMainImagesDelete(String productNo);

	int productDelete(String productNo);

	List<ProductImages> selectProductImages(String productNo);

	int productImagesDelete(String productNo);

	String findEmpid(int productNo);

	List<Map<String, Object>> empBoardList();

	EmpBoard selectOneEmpBoard(int no);

}
