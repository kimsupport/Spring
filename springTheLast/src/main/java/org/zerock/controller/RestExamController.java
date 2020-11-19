package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.RestExampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.slf4j.Slf4j;


@RestController
@RequestMapping("/rest")
@Slf4j
public class RestExamController {
	 @GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	 public String getText() {
		 log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		 return "안녕하세요"; 
	 }
	 
	 @GetMapping(value = "/getSample", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	 public RestExampleVO getSample() {
		 return new RestExampleVO(112, "Star", "Load");
	 }
	 
	 @GetMapping(value = "/getSample2")
	 public RestExampleVO getSample2() {
		 return new RestExampleVO(113, "로켓", "Rocket");
	 }
	 
	 @GetMapping(value = "/getList")
	 public List<RestExampleVO> getList() {
		 //return IntStream.range(1, 10).mapToObj(i-> new ReplyVO(i, i + "First", i + " Last")).collect(Collectors.toList());
		 return IntStream.range(1, 10)
				 .mapToObj(i -> new RestExampleVO(i,i+"이름", i+"성"))
				 .filter(i-> i.getLastName().equals("7성"))//필터로 7성에 해당되는 것만 출력
				 .map(i -> {
					 i.setMno(i.getMno() *50);
					 i.setLastName("성은 이렇게 됩니다. "+ i.getLastName()+" 99\n");
					 return i;
				 })
				 .collect(Collectors.toList());
	 }
	 
	 @GetMapping(value = "/getMap")
	 public Map<String, RestExampleVO> getMap() {
		 Map<String,RestExampleVO> map = new HashMap<String, RestExampleVO>();
		 map.put("First", new RestExampleVO(111, "그루트","JR"));
		 
		 return map;
	 }
	 
	 @GetMapping(value = "/check", params = {"height","weight"})
	 public ResponseEntity<RestExampleVO> check(Double height, Double weight) {
		 RestExampleVO vo = new RestExampleVO(0, "" + height, "" + weight);
		 ResponseEntity<RestExampleVO> result = null;
		 
		 if(height < 150) {
			 result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		 } else {
			 result = ResponseEntity.status(HttpStatus.OK).body(vo);
		 }
		 return result;
	 }
	 
	 @GetMapping("/product/{cat}/{pid}")//카테고리, ID
	 public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) {
		 return new String[] { "category: " + cat, "productid: " + pid};
	 }
	 
	 @PostMapping("/ticket")
	 public Ticket conver(@RequestBody Ticket ticket) {
		 log.info("convert.....ticket" + ticket);
		 return ticket;
	 }
}
