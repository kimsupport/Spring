<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게레겟겟</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>


  <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

  <!-- Custom styles for this page -->
  <link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
</head>
<script type="text/javascript">
$(document).ready(function(){
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action","/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});
});
</script>

<script type="text/javascript">
	console.log(replyService); //IIFE에 의해 즉시 호출되고 실행된 결과
	
	console.log("================");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	//for replyService add test
	replyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue}
			,
			function(result){
				alert("RESULT: "+result);
			}
	);
</script>
<body>
<%@ include file="../include/header.jsp" %> 

<div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
               
                
                
	<div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Board Read</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->

    <div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Read Page</div>
			<!-- panel-heading -->
            <div class="panel-body">
            
	                <div class="form-group">
	                        <label>Bno</label> 
	                        <input class="form-control" name='bno'
	                        value='<c:out value="${board.bno }"/>' readonly="readonly">
	                    </div>
	                
                    <div class="form-group">
                        <label>Title</label> 
                        <input class="form-control" name='title'
	                        value='<c:out value="${board.title }"/>' readonly="readonly">
                    </div>

                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name="content"
                        	readonly="readonly"><c:out value="${board.content }" />
                        </textarea>
                    </div>

                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control" name="writer" 
                        value='<c:out value="${board.writer }"/>'readonly="readonly">
                    </div>

                    <button data-oper='modify' 
                    	class="btn btn-default">Modify</button>
                    	<!-- onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>' " -->
                    		
                    <button data-oper='list' class="btn btn-info"
                    	onclick="location.href='/board/list'" >List</button>
               		
               		<!-- 264Page 조회페이지에서 form처리 -->
               		<form id='operForm' action="/board/modify" method="get">
               			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
               			<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
               			<input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount}"/>'>
                        <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'/>
                        <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'/>
               		</form>
               			
            </div>
            <!-- end panel-body -->
        </div>
    </div>
    
     </table>
                </div>
                </div>
                </div>
<%@ include file="../include/footer.jsp" %>    
</body>

</html>