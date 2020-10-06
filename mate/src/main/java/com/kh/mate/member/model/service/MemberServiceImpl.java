package com.kh.mate.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.mate.member.model.dao.MemberDAO;
import com.kh.mate.member.model.vo.Member;


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
}
