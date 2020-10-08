package com.kh.mate.erp.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ErpDAOImpl implements ErpDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
}
