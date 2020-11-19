package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	//public List<BoardVO> getList();
	public List<BoardVO> getList(Criteria cri);
	
	public List<BoardVO> printTitle();
	
	public void register(BoardVO board);//create
	public BoardVO get(Long bno);// read
	public boolean modify(BoardVO board);// update
	public boolean remove(Long bno); // delete
	
	public int getTotal(Criteria cri);
}
