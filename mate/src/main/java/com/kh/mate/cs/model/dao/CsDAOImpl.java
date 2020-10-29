package com.kh.mate.cs.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.cs.model.vo.CsImages;
import com.kh.mate.cs.model.vo.CsReply;
import com.kh.mate.cs.model.vo.Cs;



@Repository
public class CsDAOImpl implements CsDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Cs> selectCsList(Map<String, Object> map, int cPage, int numPerPage) {
		map.put("cPage", ((cPage-1)*numPerPage+1));
		map.put("numPerPage", (cPage * numPerPage));
		return sqlSession.selectList("cs.selectCsList", map);
	}
	
	@Override
	public int insertCs(Cs cs) {
		
		return sqlSession.insert("cs.insertCs", cs);
	}

	@Override
	public int insertCsImage(CsImages csImage) {
		
		return sqlSession.insert("cs.insertCsImage", csImage);
	}
	
	@Override
	public Cs selectOneCs(int csNo) {
		
		return sqlSession.selectOne("cs.selectOneCs", csNo);
	}
	
	@Override
	public CsImages selectCsImage(int csNo) {
		
		return sqlSession.selectOne("cs.selectCsImage", csNo);
	}

	@Override
	public CsImages selectOneAttachment(int csNo) {
		
		return sqlSession.selectOne("cs.selectOneCsImage", csNo);
	}
	
	@Override
	public int deleteCs(int csNo) {
		
		return sqlSession.delete("cs.deleteCs", csNo);
	}

	@Override
	public Cs selectOneCsCollection(int csNo) {
		
		return sqlSession.selectOne("cs.selectOneCsCollection", csNo);
	}

	@Override
	public List<CsReply> csReplyList(int csNo) {
		
		return sqlSession.selectList("csReply.selectReplyList", csNo);
	}

	@Override
	public int csReplyEnroll(CsReply csReply) {
		
		return sqlSession.insert("csReply.csInsertReply", csReply);
	}

	@Override
	public int csDeleteReply(int csReplyNo) {
		
		return sqlSession.delete("cs.csDeleteReply", csReplyNo);
	}

	@Override
	public List<Cs> selectCsList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getSearchContent() {
		return sqlSession.selectOne("cs.getSearchContents");
	}


	
	
	
}
