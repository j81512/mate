package com.kh.mate.cs.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.cs.model.vo.CsReply;

@Repository
public class CsReplyDAOImpl implements CsReplyDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void ReplyInsert(CsReply vo) {
		
	}

}
