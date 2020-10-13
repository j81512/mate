package com.kh.mate.member.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.member.model.dao.MemberDAO;
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

	
	
}
