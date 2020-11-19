package org.zerock.service;

import static org.junit.Assert.assertNotNull;

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
public class BoardServiceTests {
	@Setter(onMethod_= {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(""+service);
		assertNotNull(service);//null이 아닐때 예외 발생
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("뉴비");
		
		service.register(board);
		log.info("생성된 게시물의 번호: "+board.getBno());
	}
	/*
	@Test
	public void testList() {
		service.getList().forEach(i -> log.info(""+i));
		
	}
	*/
	@Test
	public void testGetList() {
		service.getList(new Criteria(2,10)).forEach(i -> log.info(""+i));
	}
	
	@Test
	public void testGet() {
		log.info(""+service.get(5L));
	}
	@Test
	public void testDelete() {
		log.info("삭제 결과" + service.remove(5L));
	
	}
	@Test
	public void testUpdate() {
		BoardVO board = service.get(2L);
		if(board == null) return;
		board.setTitle("제목 수정 하기");
		log.info("수정 결과 : "+service.modify(board));
	}
	
	@Test
	public void testPrintTitle() {
		service.printTitle();
	}

}
