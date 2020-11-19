package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(i -> log.info(""+i));
	}

	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		
		mapper.insert(board);
		
		log.info(""+board);
	}
	@Test
	public void testRead() {
		BoardVO a = mapper.read(1L);
		log.info(""+a);
	}
	
	@Test
	public void testDelete() {
		int a = mapper.delete(1L);
		log.info(""+a);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(5L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("Update COUNT: " + count);
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		
		//10개씩 3페이지
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(i -> log.info(""+i.getBno()));
	}
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("새로");
		cri.setType("TC");//문자열을 분리하여 검색함
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(i -> log.info(""+i));
	}
}
