<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Work Motion</title>

    <!-- Template -->
    <link href="/resources/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js"
            integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>

    <style>
        @import url("/resources/css/member/login.css");

        .none {
            display: none;
        }

        .block {
            display: block;
        }
    </style>
</head>
<body class="">


<div class="wrapper">
    <div class="container">
        <div class="sign-up-container">
            <form>
                <h1>비밀번호 찾기</h1>
                <%--                  <div class="social-links">--%>
                <%--                    <div>--%>
                <%--                      <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>--%>
                <%--                    </div>--%>
                <%--                    <div>--%>
                <%--                      <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>--%>
                <%--                    </div>--%>
                <%--                    <div>--%>
                <%--                      <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>--%>
                <%--                    </div>--%>
                <%--                  </div>--%>
                <span id="msg3" style="color: black;"></span>
                <input type="text" placeholder="이름" name="name" id="findPWname">
                <input type="email" placeholder="이메일" name="email" id="findPWemail">
                <input type="text" placeholder="전화번호" name="phone" id="findPWphone">
                <input type="text" placeholder="인증 번호확인" class="none" name="emailNum" id="emailNum">
                <button type="button" class="btn btn-light none" id="emailNumBtn">인증번호 인증</button>
                <button class="form_btn" type="button" id="findPwBtn">비밀번호 찾기</button>
                <br>
                <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#exampleModal"
                        data-bs-whatever="@mdo">아이디 찾기
                </button>
            </form>
        </div>
        <div class="sign-in-container">
            <form action="/member/login" method="POST">
                <h1>Work Motion</h1>
                <%--                <div class="social-links">--%>
                <%--                    <div>--%>
                <%--                        <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>--%>
                <%--                    </div>--%>
                <%--                    <div>--%>
                <%--                        <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>--%>
                <%--                    </div>--%>
                <%--                    <div>--%>
                <%--                        <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <span id="msg" style="color: red;">${msg}</span>
                <input type="email" name="email" value="tmdrbs727@naver.com" placeholder="이메일">
                <input type="password" name="password" value="RLAtmdrbs1070@" placeholder="비밀번호">
                <button class="form_btn">로그인</button>
                <br>
                <span><a href="/member/agree" type="button" style="color: black">회원 가입</a></span><br>
                <span><a href="/company/join" type="button" style="color: black">기업 회원 가입</a> </span>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay-left">
                <h1>로그인</h1>
                <p>thank you for coming , go login !!</p>
                <button id="signIn" class="overlay_btn">로그인</button>
            </div>
            <div class="overlay-right">
                <h1>아이디 및 비밀번호 찾기</h1>
                <p>We will find your ID or password</p>
                <button id="signUp" class="overlay_btn">찾기</button>
            </div>
        </div>
    </div>
</div>

<!-- 아이디 찾기 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">아이디 찾기</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="findIdFrm" class="form-control d-flex justify-content-center flex-column">
                    <div class="col-md-6">
                        <div class="form-floating mb-3 mb-md-0">
                            <input class="form-control" id="nameId" type="text" name="name"
                                   placeholder="Enter your name"/>
                            <label for="name">이름</label>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-floating mb-3 mb-md-0">
                            <input class="form-control" id="phoneId" type="text" name="phone"
                                   placeholder="Enter your phone"/>
                            <label for="phoneId">전화 번호</label>
                        </div>
                    </div>
                </form>
                <div class="d-flex justify-content-center">
                    <button type="button" class="btn btn-primary" id="findIdBtn">찾기</button>
                </div>
                <span id="msg2" style="color: black;"></span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="/resources/js/member/loginCheck.js"></script>
</body>
</html>