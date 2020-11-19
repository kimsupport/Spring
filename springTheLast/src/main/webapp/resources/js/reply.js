console.log("Reply Module......");

var replyService = (function(){
	function add(reply, callback){
		console.log("reply........");
		
		$.ajax({// 비동기처리, asynchronous javascript and xml
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		})
	}
	return {add:add}; //여기 add키는 get에서 호출하려는 함수명, value(add)는
	//여기에서 정의된 함수
	
})(); //IIFE (선언과 동시에 실행)