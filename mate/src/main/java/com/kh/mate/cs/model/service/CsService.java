package com.kh.mate.cs.model.service;

import java.util.List;
import java.util.Map;

import com.kh.mate.cs.model.vo.Cs;
import com.kh.mate.cs.model.vo.CsImages;
import com.kh.mate.cs.model.vo.CsReply;
import com.kh.mate.erp.model.vo.EmpBoardReply;

public interface CsService {

	List<Cs> selectCsList(Map<String, Object> map);

	int insertCs(Cs cs);

	int deleteCs(int csNo);
	
	Cs selectOneCs(int csNo);

	Cs selectOneCsCollection(int csNo);

	CsImages selectOneAttachment(int csNo);

	List<CsReply> csReplyList(int csNo);
	
	int csReply(CsReply csReply);
	
	int csDeleteReply(int csReplyNo);

	List<Cs> selectCsList();
	


	
	

}
