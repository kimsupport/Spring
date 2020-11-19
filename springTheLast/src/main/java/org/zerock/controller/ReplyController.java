package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/replies/*")
@RestController
@Slf4j
public class ReplyController {
	@Setter(onMethod_=@Autowired)
	private ReplyService service;
	
	@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO: "+vo);
		
		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT: "+ insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{bno}/{page}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page")int page, @PathVariable("bno")Long bno){
		log.info("getList.........");
		Criteria cri = new Criteria(page,10);
		log.info(""+cri);
		
		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
	}//중괄호는 PathVariable에 /replies/pages/61(bno)/1(page?)
	
	@DeleteMapping(value="/{rno}", produces= {MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<String> remove( @PathVariable("rno") Long rno){
		
		log.info("remove"+rno);
		
		return service.remove(rno) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
						:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 요기는 수업시간에 사용한 방식의 Update
	@PatchMapping(value="/{rno}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
		vo.setRno(3L);
		log.info("댓글 컨트롤러에서의 수정 "+rno + "vo: "+vo);
		return service.modify(vo)==1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
	
}
