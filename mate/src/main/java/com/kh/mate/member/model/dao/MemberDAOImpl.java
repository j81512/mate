package com.kh.mate.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.member.model.vo.Address;
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

	@Override
	public List<Map<String, Object>> selectAllPurchase(String memberId) {
		return sqlSession.selectList("member.selectAllPurchase", memberId);
	}

	@Override
	public List<Address> selectMemberAddress(String memberId) {
		return sqlSession.selectList("member.selectMemberAddress", memberId);
	}

	@Override
	public int checkAddressName(Map<String, Object> param) {
		return sqlSession.selectOne("member.checkAddressName", param);
	}

	@Override
	public int insertAddress(Map<String, Object> param) {
		return sqlSession.insert("member.insertAddress", param);
	}

	@Override
	public int successPurchase(int purchaseNo) {
		return sqlSession.update("member.successPurchase", purchaseNo);
	}

	@Override
	public int failPurchase(int purchaseNo) {
		return sqlSession.delete("member.failPurchase", purchaseNo);
	}

	@Override
	public List<Member> searchMember(String searchKeyword, String searchType, int cPage, int numPerPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cPage", ((cPage-1)*numPerPage+1));
		map.put("numPerPage", (cPage * numPerPage));
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		
		return sqlSession.selectList("member.searchMember", map);
	}

	@Override
	public int getSearchContent(Map<String, String> map) {
		return sqlSession.selectOne("member.searchContent", map);
	}

	
	
	
	
}
