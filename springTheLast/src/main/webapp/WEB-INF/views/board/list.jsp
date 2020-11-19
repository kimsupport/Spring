<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		var result = '<c:out value="${result}"/>';
			
		checkModal(result);
		
		/* 257Page. '뒤로가기나 앞으로가기할때 ' 모달창을 띄울 필요 없다고 표시하기 */
		history.replaceState({},null,null);
		
		function checkModal(result){
			if(result === '' || history.state) {//여기도 조건 추가 || history.state
				return;
			}
			
			if (parseInt(result) >0){
				$(".modal-body").html("게시글" + parseInt(result) + " 번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function(){
			self.location = "/board/register";
		});
		
		/* 페이지선택을 위한 Script */
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click",function(e){
			e.preventDefault();
			console.log('검사검사 '+$(this).attr("href"));
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
			
			//id가 actionForm (Form, input type = hidden)
			//class가 paginate_button 하위요소의 a태그 눌리면, a의 속성값 href
			//찾고 그 값(url) 가져도 actionForm > input type name = pageNum
			//찾은 url을 저장.
		});
		
		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+
					$(this).attr("href")+"'>");
			actionForm.attr("action","/board/get");
			actionForm.submit();
		});
		
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});
	});
</script>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title> 🦉부엉이 게시판🦉  </title>

<!-- Custom fonts for this template -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<%--     <!-- Sidebar -->
		<%@ include file="../include/sidebar.jsp" %>
		<!-- End of Sidebar --> --%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<%@ include file="../include/header.jsp" %>
				<!-- End of Topbar -->
				<!-- Begin Page Content -->
				<div class="container-fluid">
				<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">Tables</h1>
					<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the <a target="_blank" href="https://datatables.net">official DataTables documentation</a>.</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">게시글 목록</h6>
							<!-- 250Page에서 추가 -->
							<div class="panel-heading">Board List Page
								<button id='regBtn' type="button" class="btn btn-warning pull-right">새 게시물 등록 📖📙📚 </button>
							</div>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>작성일</th>
											<th>수정일</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>작성일</th>
											<th>수정일</th>
										</tr>
									</tfoot>
									<tbody>
										<c:forEach items="${list}" var="board">
											<tr>
												<td><c:out value= "${board.bno }" /></td>
												<!-- 254page a링크 삽입 -->
												<td>
												<a class='move' href='<c:out value="${board.bno}"/>'>
												<c:out value= "${board.title }" /> </a> 
												</td>
												<td><c:out value= "${board.writer }" /></td>
												<td><fmt:formatDate pattern = "yyyy-MM-dd" value= "${board.regDate }" /></td>
												<td><fmt:formatDate pattern = "yyyy-MM-dd" value= "${board.updateDate }" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<!-- End of DataTables Example -->
								
								<!-- Start Pagination -->

								<div class='pull-right'>
									<ul class="pagination">
										<c:if test="${pageMaker.prev}">
											<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a></li>
										</c:if>
										<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
											<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} ">
												<a href="${num}">${num}</a>
											</li> 
										</c:forEach>
										<c:if test="${pageMaker.next}">
											<li class="paginate_button next">
												<a href="${pageMaker.endPage +1 }">Next</a>
											</li>
										</c:if>
									</ul>
								</div>

								<!-- End Pagination -->
			
								<!-- 검색 조건 생성과 키워드 -->
								<div class='row'>
									<div class="col-lg-12">
										<form id='searchForm' action="/board/list" method="get">
											<select name='type'>
												<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
												<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
												<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
												<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
												<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
												<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
												<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
											</select>
											<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/>
											<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
											<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'/>
											<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
											<button class='btn btn-default'>Search</button>
										</form>
									</div>
								</div>
								
								<form id='actionForm' action="/board/list" method='get'>
									<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum}'>
									<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
									<input type='hidden' name='type' value = '${pageMaker.cri.type}'>
									<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
								</form>
								
								
								
								<!-- Start Modal -->
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class = "modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class = "close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title" id="myModalLabel">Modal title</h4>
											</div>
											<div class = "modal-body">처리가 완료되었습니다.</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
												<button type="button" class="btn btn-primary">Save changes</button>
											</div>
										</div>
									</div><!-- /.modal-content -->
								</div><!-- /.modal-dialog -->
							</div>
						</div>
					</div>
				</div><!-- /.container-fluid -->
			</div><!-- End of Main Content -->
		</div><!-- End of Content Wrapper -->
		<!-- footer -->
		<%@ include file="../include/footer.jsp" %>
		<!-- footer -->
	</div><!-- End of Page Wrapper -->
</body>
</html>