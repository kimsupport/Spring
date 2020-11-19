package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class ReplyMapperTests {
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	private Long[] bnoArr = { 1L, 2L, 3L, 4L, 5L};
	
	@Test
	public void testMapper() {
		log.info(""+mapper);
	}
	
	
	@Test
	public void testInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(25L);
		vo.setReply("여기는 25번의 댓글 내용");
		vo.setReplyer("여기는 25번 댓글 작성자" );
		mapper.insert(vo);
	}
	
	@Test
	public void testRead() {
		ReplyVO vo = mapper.read(1L);
		
		log.info(""+vo);
	}
	
	@Test
	public void testUpdate() {
		ReplyVO vo = mapper.read(1L);
		vo.setReply("업데이트된 댓글");
		
		mapper.update(vo);
	}
	
	@Test
	public void testDelete() {
		mapper.delete(1L);
	}
	
	@Test
	public void testList() {
		
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(i -> log.info(""+i));
	}
}
