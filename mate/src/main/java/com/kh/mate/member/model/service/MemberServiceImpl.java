package com.kh.mate.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.member.model.dao.MemberDAO;
import com.kh.mate.member.model.vo.Address;
import com.kh.mate.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;

	@Override
	public int insertMember(Member member) {
		return memberDAO.insertMember(member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	@Override
	public int updateMember(Map<String, Object> map) {
		return memberDAO.updateMember(map);
	}

	@Override
	public int deleteMember(Map<String, Object> map) {
		return memberDAO.deleteMember(map);
	}

	@Override
	public List<Map<String, Object>> selectAllPurchase(String memberId) {
		return memberDAO.selectAllPurchase(memberId);
	}

	@Override
	public List<Address> selectMemberAddress(String memberId) {
		return memberDAO.selectMemberAddress(memberId);
	}

	@Override
	public int checkAddressName(Map<String, Object> param) {
		return memberDAO.checkAddressName(param);
	}

	@Override
	public int insertAddress(Map<String, Object> param) {
		return memberDAO.insertAddress(param);
	}

	@Override
	public int successPurchase(int purchaseNo) {
		return memberDAO.successPurchase(purchaseNo);
	}

	@Override
	public int failPurchase(int purchaseNo) {
		return memberDAO.failPurchase(purchaseNo);
	}

	@Override
	public List<Member> searchMember(String searchType, String searchKeyword, int cPage, int numPerPage) {
		return memberDAO.searchMember(searchKeyword,searchType,cPage,numPerPage);
	}

	@Override
	public int getSearchContents(Map<String, String> map) {
		return memberDAO.getSearchContent(map);
	}

	
	
}
