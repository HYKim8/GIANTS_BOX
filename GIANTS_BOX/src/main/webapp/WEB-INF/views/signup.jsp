<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="cmn/header.jsp"%>



<main class="page registration-page" style="padding-top: 65px;">
	<section class="clean-block clean-form dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-primary">Sign up</h2>
			</div>
			<form onsubmit="return false;">
				<div class="form-group row" >
					<label class="col-lg-12" for="id" id ="id_label">Id</label>
					<div class="col-lg-9">
						<input class="form-control item" type="text" id="id" >
					</div>
						<input class="btn btn-sm btn-primary" type="button" value="ID중복확인" id="id_check" />
				</div>
				<div class="form-group">
					<label for="name" id ="name_label">Name</label><input class="form-control item"
						type="text" id="name">
				</div>
				
				<div class="form-group" >
					<label for="password"  id ="password_label">Password</label><input
						class="form-control item" type="password" id="password" placeholder="영문자,숫자,특수문자를 조합해 8자리 이상 작성해주세요">
				</div>
				
				<div class="form-group" >
					<label for="password"  id ="passwordConf_label">Password Check</label><input
						class="form-control item" type="password" id="passwordConf" placeholder="비밀번호를 한 번 더 입력해주세요">
				</div>
				
				<div class="form-group">
					<label for="email" id ="email_label">Email</label><input class="form-control item"
						type="email" id="email">
				</div>	
					
				<div class="form-group">
					<label for="phone" id ="phone_label">Phone(ex. -없이 번호만 입력해주세요)</label><input class="form-control item"
						type="text" id="phone">
				</div>
				
				<div class="form-group">
					<label for="birthday" id ="birthday_label">Birthday(ex.970123)</label><input
						class="form-control item" type="text" id="birthday">
				</div>
 				
				<div class="form-group">
						<label for="genre" id ="genre_label">좋아하는 영화장르 선택</label></br>
						<label for="genre1"><input type="radio" id="genre1" name="genre" value="드라마">드라마</label>
   						<label for="genre2"><input type="radio" id="genre2" name="genre" value="액션">액션</label>
   						<label for="genre3"><input type="radio" id="genre3" name="genre" value="멜로">멜로</label>
   						<label for="genre4"><input type="radio" id="genre4" name="genre" value="공포(호러)">공포(호러)</label>
   						<label for="genre5"><input type="radio" id="genre5" name="genre" value="범죄">범죄</label></br>
   						<label for="genre6"><input type="radio" id="genre6" name="genre" value="코메디">코메디</label>
   						<label for="genre7"><input type="radio" id="genre7" name="genre" value="가족">가족</label>
   						<label for="genre8"><input type="radio" id="genre8" name="genre" value="SF">SF</label>
   						<label for="genre9"><input type="radio" id="genre9" name="genre" value="판타지">판타지</label>
   						<label for="genre10"><input type="radio" id="genre10" name="genre" value="">기타</label>	    	    	 		  		  		  		  		  		 	 		 	 	
			    </div>
				<button class="btn btn-primary btn-block"  id="doReg">Sign
					Up</button>
			</form>
			
		</div>
	</section>
</main>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript">
    //회원가입
	$("#doReg").on("click", function() {
		
		
		var id = $("#id").val();
		id = id.trim();
		if (null == id || id.length == 0) {
			$("#id").focus();
			alert("아이디를 입력 하세요.");//{0} 입력하세요.
			$("#Id_label").css("color","red"); 
			return;
		}

		var name = $("#name").val();
		name = name.trim();
		if (null == name || name.length == 0) {
			$("#name").focus();
			alert("이름을 입력 하세요.");//{0} 입력하세요. 
			$("#name_label").css("color","red");
			return;
		}

		var password = $("#password").val();
		password = password.trim();
		if (null == password || password.length == 0) {
			$("#password").focus();
			alert("비밀번호를 입력 하세요.");//{0} 입력하세요.
			return;
		}


		var passwordConf = $("#passwordConf").val();
		passwordConf = passwordConf.trim();
		if (password != passwordConf) {
			$("#password").focus();
			alert("비밀번호를 확인 하세요.");//{0} 입력하세요.
			$("#passwordConf_label").css("color","red");
			return;
		}
		

		var email = $("#email").val();
		email = email.trim();
		if (null == email || email.length == 0) {
			$("#email").focus();
			alert("이메일을 입력 하세요.");//{0} 입력하세요.
			$("#email_label").css("color","red"); 
			return;
		}

		var phone = $("#phone").val();
		phone = phone.trim();
		if (null == phone || phone.length == 0) {
			$("#phone").focus();
			alert("폰 번호를 입력 하세요.");//{0} 입력하세요. 
			$("#phone_label").css("color","red");
			return;
		}

		var birthday = $("#birthday").val();
		birthday = birthday.trim();
		if (null == birthday || birthday.length == 0) {
			$("#birthday").focus();
			alert("생년월일을 입력 하세요.");//{0} 입력하세요.
			$("#birthday_label").css("color","red"); 
			return;
		}
		var genre = $('input[name="genre"]:checked').val();
		if (null == genre || genre.length == 0) {
			$("#birthday").focus();
			alert("생년월일을 입력 하세요.");//{0} 입력하세요.
			$("#birthday_label").css("color","red"); 
			return;
		}

		$.ajax({
			type : "POST",
			url : "${context}/regUser.do",
			dataType : "html",
			data : {
				"userId" : $("#id").val(),
				"name" : $("#name").val(),
				"password" : $("#password").val(),
				"email" : $("#email").val(),
				"cellPhone" : $("#phone").val(),
				"birthday" : $("#birthday").val(),
				"genre"  : $('[name=genre]:checked').val()
			},
			success : function(data) { //성공

				var obj = JSON.parse(data);
				//alert(obj.msgContents);
				alert(obj.msgContents);
				if(obj.msgId == 1){
					window.location.href="${context}/login.do";
				}else{
					$("#password_label").css("color","red");
				}
				
			},
			error : function(xhr, status, error) {
				alert("error:" + error);
			},                    
			complete : function(data) {
			}

		});//--ajax

	});


	//id 중복체크
	$("#id_check").on("click", function() {

		var id = $("#id").val();
		id = id.trim();
		if (null == id || id.length == 0) {
			$("#id").focus();
			alert("아이디를 입력 하세요.");//{0} 입력하세요.
			return;
		}
		
		$.ajax({
			type : "POST",
			url : "${context}/checkId.do",
			dataType : "html",
			data : {
				"userId" : $("#id").val(),
			},
			success : function(data) { //성공

				var obj = JSON.parse(data);
				//alert(obj.msgContents);
				alert(obj.msgContents);
			
			},
			error : function(xhr, status, error) {
				alert("error:" + error);
			},                    
			complete : function(data) {
			}

		});//--ajax

	});
</script>

<%@ include file="cmn/footer1.jsp" %>
<!-- 자바스크립트 자리 -->
<%@ include file="cmn/footer2.jsp" %>
