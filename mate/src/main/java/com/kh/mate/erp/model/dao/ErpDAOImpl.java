package com.kh.mate.erp.model.dao;

import java.util.List;

import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

@Repository
public class ErpDAOImpl implements ErpDAO {


	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public EMP selectOneEmp(String empId) {
		return sqlSession.selectOne("emp.selectOneEmp", empId);
	}

	@Override
	public int insertEmp(EMP emp) {
		return sqlSession.insert("emp.insertEmp", emp);
	}

	@Override
	public List<Product> searchInfo(Map<String, Object> map) {
		return sqlSession.selectList("erp.searchInfo",map);
	}
	
	
  @Override
	public List<EMP> empList(EMP emp) {
		return sqlSession.selectList("emp.empList");
	}

	@Override
	public Product orderProduct(Map<String, Object> map) {
		return sqlSession.selectOne("erp.orderProduct",map);
	}

  
  //김종완
	
	@Override
	public int productEnroll(Product product) {
		return sqlSession.insert("erp.productEnroll", product);
	}

	@Override
	public int productImageEnroll(ProductImages pigs) {
		return sqlSession.insert("erp.productImageEnroll", pigs);
	}

	@Override
	public Product selectProductOne(String productNo) {
		return sqlSession.selectOne("erp.selectProductOne", productNo);
	}

	@Override
	public List<ProductMainImages> selectProductMainImages(String productNo) {
		return sqlSession.selectList("erp.selectProductMainImages", productNo);
	}
	
  

	
}
