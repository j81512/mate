package com.kh.mate.cs.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.cs.model.vo.Cs;

@Repository
public class CsDAOImpl implements CsDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertCs(Cs cs) {
		
		return sqlSession.insert("cs.insertCs", cs);
	}

}
