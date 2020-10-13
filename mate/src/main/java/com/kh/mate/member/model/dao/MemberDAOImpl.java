package com.kh.mate.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.member.model.vo.Member;
@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member selectOneMember(String memberId) {
		return sqlSession.selectOne("member.selectOneMember", memberId);
	}

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}

	@Override
	public int updateMember(Map<String, Object> map) {
		return sqlSession.update("member.updateMember", map);
	}

	@Override
	public int deleteMember(Map<String, Object> map) {
		return sqlSession.delete("member.deleteMember", map);
	}

	
	
	
	
}
