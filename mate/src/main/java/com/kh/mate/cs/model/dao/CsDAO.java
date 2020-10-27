package com.kh.mate.cs.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.mate.cs.model.vo.CsImages;
import com.kh.mate.cs.model.vo.CsReply;
import com.kh.mate.cs.model.vo.Cs;


public interface CsDAO {

	int insertCs(Cs cs);

	List<Cs> selectCsList(Map<String, Object> map);

	int deleteCs(int csNo);

	CsImages selectOneAttachment(int csNo);
	
	Cs selectOneCsCollection(int csNo);

	Cs selectOneCs(int csNo);

	int insertCsImage(CsImages csImage);

	CsImages selectCsImage(int csNo);

	List<CsReply> csReplyList(int csNo);

	int csReplyEnroll(CsReply csReply);

	int csDeleteReply(int csReplyNo);

}
