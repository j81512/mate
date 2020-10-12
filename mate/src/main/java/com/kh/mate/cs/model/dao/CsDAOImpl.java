package com.kh.mate.cs.model.dao;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<Cs> selectCsList() {
		
		return sqlSession.selectList("cs.selectCsList");
	}
	@Override
	public int deleteCs(Map<String, String> param) {
		
		return sqlSession.delete("Cs.deleteCs", param);
	}
}
