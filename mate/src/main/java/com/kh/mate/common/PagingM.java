package com.kh.mate.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingM {
	

	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private PagingC pgc;

	public PagingM(PagingC pgc, int total) {
		this.pgc = pgc;
		int realEnd = (int)(Math.ceil((total * 1.0)/pgc.getAmount()));
		this.endPage = (int)(Math.ceil(pgc.getPageNum() / 10.0) * 10);
		this.startPage = getEndPage()-9;
		
		if(realEnd < this.endPage) {
			this.endPage=realEnd;
		}
		
		this.next = getEndPage() < realEnd;
		this.prev = getStartPage() >1;
		
	}
	
	
}
