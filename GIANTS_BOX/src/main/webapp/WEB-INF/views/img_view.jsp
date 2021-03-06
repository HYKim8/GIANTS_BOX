<%--
/**
	Class Name:
	Description:
	Modification information
	
	수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2020. 9. 18        최초작성 
    
    author eclass 개발팀
    since 2020.05
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath }"></c:set>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>img view</title>
	
  </head>
<body>
<div id="wrap">
<%-- 	<%@include  file="/cmn/inc/header.jsp" %> --%>
	<section>
		<!-- container -->
		<div class="container">
			<!-- 제목 -->
			<div class="page-header">
				<h2>사진 보기</h2>
			</div>
			<!--// 제목 -->
			
			<ul id = "img_list"></ul>
			
		</div>
		<!--// container -->
	</section>
<%--     <%@include  file="/cmn/inc/footer.jsp" %>	 --%>
</div>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>   
    
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <%-- <script src="${context}/resources/js/bootstrap.min.js"></script> --%>
    
    <!-- javascript -->
    <script type="text/javascript">
    
	    //모든 컨트롤(element)가 로딩이 완료되면.
		$(document).ready(function(){   
			console.log("document ready"); 
		});//document ready

		
		// 스크롤바 상태
		let isEnd = false;

		// 컨텍스트
		let context = '<c:out value="${context}" />';

		// 페이지 넘버
		let num = 0;

		$(function(){
			$(window).scroll(function(){
				let $window = $(this);
				let scrollTop = $window.scrollTop();
				let windowHeight = $window.height();
				let documentHeight = $(document).height();

				console.log("[scrollTop] " + scrollTop + "|"
						+ "[windowHeight] " + windowHeight + "|"
						+ "[documentHeight] " + documentHeight);

				//스크롤바의 thumb가 바닥 전 30px까지 도달하면 리스트 가져오기
				if(scrollTop + windowHeight + 30 > documentHeight){
					console.log("scroll bar 30px reached");
					
					fetchList();
				}
				
			})//---END #(window).scroll
			
			fetchList();
			
			
		})//---END function
		
	//---fetchList
	let fetchList = function(){
		console.log("fetchList()");
		num = ++num;
		
		if(isEnd == true){
			console.log("isEnd true");
			return;
		}
	
		// <li> 태그의 data-no 속성 가져오기
		let startNo = $("#img_list li").last().data("no") || 0;
		console.log("startNo : " + startNo);
	
		
		$.ajax({
			url: "${context}/img/fetchList.do",
			data: { "eventSeq" : "2",
				"maxImgSeq" : ${maxImgSeq},
				"num" : num
				},
			type: "POST",
			//dataType: "application/json"
			success: function(result){
				//String -> JSON 객체로 변환 
				let data = JSON.parse(result);
				let length = data.length;
				
	
				//남은 데이터가 5개 이하일 경우 무한 스크롤 끝내기
				//if(length < 5) {
				//	isEnd = true;
				//}
	
				// 목록 렌더링
				$.each(data, function(index, data){
					renderList(false, data.imgVO);
				});
			}//---END success
		});//---END ajax
	}//---END fetchList

	

	// 렌더링
	let renderList = function(mode, vo){
		let html =
			"<li data-no='" + vo.num + "'>" +
			"<p>" + vo.num + "</p>" +
			"<p>" + vo.regDt + "</p>" +
			"<p>" + vo.regId + "</p>" +
			"<strong>" + vo.originName + "</strong>" + 
			"<img src=" + context + "/img/" + vo.imgSeq + ".do >" + 
			"<a href='#' data-no='" + vo.num + "'>삭제</a>" + "</li>"
		if(mode) {
			$("#img_list").prepend(html);
		} else {
			$("#img_list").append(html);
		}
	}//---END renderList



		   

		
	</script>
    
  </body>
</html>