<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="url" value="54.180.100.17" />
<!DOCTYPE html>
<html>
<head>
  <title>Study Anywhere</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }

    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
    
    .container{
    	padding: 130px;
    }
  </style>
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="./">Study Anywhere</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
    
<!--       <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Gallery</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
 -->      <ul class="nav navbar-nav navbar-right">
 
		<c:choose>
        	<c:when test="${empty loginInfo.getMEMBER_ID()}">
		<li><a data-toggle="modal" data-target="#loginForm"><span class="glyphicon glyphicon-log-in"></span> Sign in</a></li>
        <li><a data-toggle="modal" data-target="#joinForm"><span class="glyphicon glyphicon-user"></span> Sign up</a>
        	</c:when>
        	
        	<c:otherwise>
		<li><a href="./myPage.jsp"><span class="glyphicon glyphicon-log-in"></span> My page</a></li>
        <li><a href="./memberLogout.do"><span class="glyphicon glyphicon-log-out"></span> Sign out</a>
        	</c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>

<div class="jumbotron" style="height:600px">
  <div class="container text-center">
    <h1>Study Anywhere</h1>
    <p>많은 사람들이 서로의 의견을 교환하고 지식을 높이는데 노력하고 있습니다.<br>
지금 참여하여 당신의 생각과 공부법을 공유해 보세요!</p>
	<br>
	
	<c:choose>
		<c:when test="${empty loginInfo.getMEMBER_ID()}">
	<button class="btn btn-lg btn-primary" data-toggle="modal" data-target="#joinForm" style="50px">지금 가입하세요!</button>
		</c:when>
		<c:otherwise>
	<button class="btn btn-lg btn-primary" onClick="location.href='http://${ url }:3000'" style="50px">시작하기!</button>
		</c:otherwise>
	</c:choose>
  </div>
</div>


<footer class="container-fluid text-center">
  <p>KITRI 디지털 컨버젼스 28기</p>
</footer>


	<script>
		var overlap = 0; // 0  중복체크 안함, 1 했고 중복 안됌
		var passConfirm = 0;

		/* 아이디 중복체크 */
		function idCheck() {
			var id = document.getElementById("joinId");

			console.log("idCheck 실행");
			if (id.value == "") {
				console.log("null if문 실행")
				alert('id를 입력해주세요');
				return;
			} else if (id.value.match(/[가-힣ㄱ-ㅎㅏ-ㅣ]/)) {
				alert('아이디는 한글을 제외해 주세요.');
				return;
			}

			var req = new XMLHttpRequest();
			req.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var out = JSON.parse(this.responseText);
					if (out.result == "yes") {
						alert('아이디가 존재합니다.');
					} else {
						alert('사용 가능한 아이디 입니다.');
						overlap = 1; // 중복체크 완료
						var checkbutton = document
								.getElementById("checkButton");
						checkbutton.className += " disabled";
						id.disabled = true;
						console.log('버튼 비활성화 완료');
						document.getElementById("tempId").value = id.value;
					}
				}
			}
			req.open("GET", "./idOverlapCheck.do?check=" + id.value, true);
			req.send();
		}

		/* 패스워드 일치 알림 */
		function passCheck() {
			var pass1 = $("#pass1").val();
			var pass2 = $("#pass2").val();
			if (pass1 != pass2) {
				$("#passCheckMessage").html("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				$("#pass1").addClass("warn");
				$("#pass2").addClass("warn")
			} else {
				$("#passCheckMessage").html("");
				$("#pass1").removeClass("warn");
				$("#pass2").removeClass("warn");
				passConfirm = 1;
			}
		}

		/* 가입 버튼 */
		function join() {
			var email = $("#inputEmail").val();
			if (overlap == 0) {
				alert("id 중복체크를 해주세요.");
				return false;
			} else if (passConfirm == 0) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			} else if (email == "") {
				console.log(email);
				alert("이메일을 입력해 주세요.");
				return false;
			} else if (overlap == 1 && passConfirm == 1) {
				$("#joinFomat").submit();
			}
		}
	</script>


	<!-- 로그인(modal) -->
	<div class="modal" id="loginForm">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">로그인</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<form action="memberLogin.do" method="post">
					<div class="form-group">
						<div class="modal-body">
							<h5>
								<label>아이디</label>
							</h5>
							<input class="form-control" name="loginId" type="text" id="id" value="java" />
							<h5>
								<label>비밀번호</label>
							</h5>
							<input class="form-control" name="loginPwd" type="password"
								id="pwd" value="1234" /> <a data-toggle="modal" data-target="#MissingForm"><u>혹시 비밀번호를 잊어버리셨나요?</u></a>
						</div>
						<div class="modal-footer">
							<button class="btn btn-dark" type="submit">로그인</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>



	<!-- 회원가입(modal) -->
	<div class="modal" id="joinForm">
		<div class="modal-dialog">
			<div class="modal-content" style="padding: 50px">
				<div class="modal-header">
					<h4 class="modal-title">회원가입</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form action="memberJoin.do" method="post" id="joinFomat">
					<div class="form-group">
						<div class="modal-body">

							<div class="row">
								<div class="col-sm">
									<h5>
										<label>아이디</label>
									</h5>
									<div class="row">
										<div class="col-sm-9">
											<input class="form-control" name="MEMBER_ID" type="text"
												maxlength="10" id="joinId" placeholder="아이디를 입력해 주세요." /> 
											<input class="form-control" name="memberID" type="hidden"
												maxlength="10" id="tempId" placeholder="아이디를 입력해 주세요." />
										</div>

										<div class="col-sm-3">
											<button type="button" class="btn btn-dark" id="checkButton"
												onclick="idCheck()">중복체크</button>
											<!-- 중복체크 완료시 disable -->
										</div>
									</div>
								</div>
							</div>

							<div class="row mt-2 mb-2">

								<div class="col-sm">
									<label><h5>비밀번호</h5></label> <input class="form-control"
										name="MEMBER_PW" type="password" id="pass1"
										onkeyup="passCheck()" placeholder="비밀번호를 입력해 주세요." />
								</div>

								<div class="col-sm">
									<label><h5>비밀번호 확인</h5></label> <input class="form-control"
										type="password" id="pass2" onkeyup="passCheck()"
										placeholder="한번 더  입력해 주세요." />
								</div>

							</div>

							<label><h5>이메일</h5></label> <input class="form-control"
								name="MEMBER_EMAIL" type="email" id="inputEmail"
								placeholder="이메일을 입력해 주세요." />

						</div>
						<div class="modal-footer">
							<p style="color: red;" id="passCheckMessage"></p>
							<button type="button" class="btn btn-dark" onclick="join()">가입</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<form action="memberFindPass.do" method="post">
		<div class="modal" id="MissingForm">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">비밀번호 찾기</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<div class="modal-body">
						현재 아이디를 입력하시면, 가입 정보에 기입된 이메일로 안내 메일을 발송해 드립니다. <input
							class="form-control" type="text" name="memberID"
							placeholder="아이디를 입력해주세요.">
					</div>

					<div class="modal-footer">
						<p style="color: red;" id="passCheckMessage"></p>
						<button class="btn btn-dark" type="submit">이메일 전송</button>

					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>
