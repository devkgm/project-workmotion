<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
           prefix="c" %>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Work Motion</title>
    <link rel="icon" href="/resources/images/favicon.ico"/>
    <link
            rel="stylesheet"
            href="/resources/css/project/createTask.css"
            type="text/css"
    />
    <!-- Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&display=swap"
            rel="stylesheet"
    />
    <!-- Template -->
    <link href="/resources/css/styles.css" rel="stylesheet"/>
    <script
            src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
            crossorigin="anonymous"
    ></script>

    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
    />
    <!-- Socket -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <!-- Jquery -->
    <script
            src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"
    ></script>
    <!-- Tagify 다운 -->
    <script src="https://unpkg.com/@yaireo/tagify"></script>
    <!-- 폴리필 (구버젼 브라우저 지원) -->
    <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
    <link
            href="https://unpkg.com/@yaireo/tagify/dist/tagify.css"
            rel="stylesheet"
            type="text/css"
    />
    <!-- summernote -->
    <link
            href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
            rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />

    <style>
        #messengerButton {
            right: 5%;
            width: 40vh;
        }

        #messenger {
            width: 40vh;
            height: 60vh;
            right: 5%;
            border: 1px solid lightgray;
            border-top-left-radius: 1vh;
            border-top-right-radius: 1vh;
            z-index: 2;
        }

        #messenger .sidebar {
            width: 5vh;
            border-top-left-radius: 1vh;
            background-color: #e6e6e6;
        }

        #messenger .sidebar button {
            padding: 0px;
            width: 1.4vh;
            height: 1.4vh;
            border-radius: 100%;
            font-size: 1.4vh;
            line-height: 1vh;
            font-weight: 100;
        }

        #messenger .sidebar button.active {
            color: black !important;
        }

        #messenger .nav-item .fa-user {
            font-size: 2.4vh;
        }

        #messenger .nav-item .fa-comment {
            font-size: 2.2vh;
        }

        #messengerBody {
            background-color: white;
        }

        .fa-search {
            color: lightgray;
        }

        #chat3 .form-control {
            border-color: transparent;
        }

        #chat3 .form-control:focus {
            border-color: transparent;
            box-shadow: inset 0px 0px 0px 1px transparent;
        }

        .badge-dot {
            border-radius: 50%;
            height: 10px;
            width: 10px;
            margin-left: 2.9rem;
            margin-top: -0.75rem;
        }

        a {
            text-decoration: none;
        }

        .memberList.selected {
            background-color: #f2f2f2;
        }

        .memberList:hover {
            background-color: #f2f2f2;
        }

        .accordionCustom {
            height: 2vh;
        }

        .accordion-collapse.collapse.show + .accordion-button .arrow-icon {
            transform: rotate(180deg);
        }

        #memberContainer {
            height: 54vh;
        }

        .popover-body {
            padding: 0;
        }
    </style>
</head>
<body class="sb-nav-fixed" data-bs-memberId="${member.id}">
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <!-- Navbar Brand-->
    <a class="navbar-brand ps-3" href="/projects/list">WorkMotion</a>

    <!-- Sidebar Toggle-->
    <button
            class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
            id="sidebarToggle"
            href="#!"
    >
        <i class="fas fa-bars"></i>
    </button>
    <!-- Navbar Search-->

    <form
            class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
    >
        <div class="input-group">
            <div class="me-2">
                <c:if test="${member.role_id == 40}">
                    <c:if test="${!empty check}">
                        <a href="/product/list"
                        >
                            <button
                                    type="button"
                                    class="btn btn-primary"
                            >
                                현재 구독서비스
                                이용중입니다(${toss}주남음)
                            </button>
                        </a
                        >
                    </c:if>
                    <c:if test="${empty check}">
                        <a href="/product/list"
                        >
                            <button
                                    type="button"
                                    class="btn btn-danger"
                            >
                                구독서비스를 이용해주세요
                            </button>
                        </a
                        >
                    </c:if>
                </c:if>
            </div>
            <div class="me-2">
                <a class="btn btn-primary" href="/tna/in">출 근</a>
            </div>
            <div class="me-2">
                <a class="btn btn-primary" href="/tna/out">퇴 근</a>
            </div>
        </div>
    </form>
    <div class="d-none d-md-inline-block me-0 me-md-3 my-2 my-md-0">
        <a
                class="order-1 order-lg-0 me-lg-0"
                data-bs-container="body"
                data-bs-toggle="popover"
                data-bs-placement="bottom"
                data-bs-content="Bottom popover"
                data-htmlcontent="#myPopoverContent"
                href="javascript: void(0)"
        >
            <i class="fa-solid fa-bell"></i>
        </a>
        <div id="myPopoverContent" hidden>
            <div class="d-flex justify-content-between m-2">
                <div class="title">알림</div>
                <div class="small text-muted">
                    <a href="#" class="link-secondary">모두 읽음</a>
                </div>
            </div>
            <div class="">
                <hr class="m-0"/>
            </div>
            <ul class="list-group p-1">
                <li class="list-group-item">
                    <i class="fa-solid fa-bell"></i>
                    <div>경모님의 메시지</div>
                    <div class="small text-muted">뭐하고있냐</div>
                </li>
                <li class="list-group-item">
                    <div>워크모션 프로젝트에 참여되었습니다.</div>
                </li>
                <li class="list-group-item">
                    <div>프로젝트 마감 일정이 1일 남았습니다.</div>
                </li>
            </ul>
        </div>
    </div>
    <!-- Navbar-->
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
        <li class="nav-item dropdown">
            <a
                    class="nav-link dropdown-toggle"
                    id="navbarDropdown"
                    href="#"
                    role="button"
                    data-bs-toggle="dropdown"
                    aria-expanded="false"
            ><i class="fas fa-user fa-fw"></i
            ></a>
            <ul
                    class="dropdown-menu dropdown-menu-end"
                    aria-labelledby="navbarDropdown"
            >
                <li>
                    <a class="dropdown-item" href="/member/mypage"
                    >마이페이지</a
                    >
                </li>
                <li>
                    <hr class="dropdown-divider"/>
                </li>
                <li>
                    <a class="dropdown-item" href="/member/logout"
                    >로그아웃</a
                    >
                </li>
            </ul>
        </li>
    </ul>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav
                class="sb-sidenav accordion sb-sidenav-dark"
                id="sidenavAccordion"
        >
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <!-- <div class="sb-sidenav-menu-heading">Core</div>
                    <a class="nav-link" href="/">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-tachometer-alt"></i>
                        </div>
                        Dashboard
                    </a> -->
                    <div class="sb-sidenav-menu-heading">메뉴</div>
                    <a
                            class="nav-link collapsed"
                            href="/projects/list"
                            data-bs-target="#collapseLayouts"
                            aria-expanded="false"
                            aria-controls="collapseLayouts"
                    >
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-columns"></i>
                        </div>
                        프로젝트
                        <div class="sb-sidenav-collapse-arrow">
                            <i class="fas fa-angle-down"></i>
                        </div>
                    </a>
                    <a
                            class="nav-link collapsed"
                            href="#"
                            data-bs-toggle="collapse"
                            data-bs-target="#collapsePages"
                            aria-expanded="false"
                            aria-controls="collapsePages"
                    >
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-pen"></i>
                        </div>
                        전자결제
                        <div class="sb-sidenav-collapse-arrow">
                            <i class="fas fa-angle-down"></i>
                        </div>
                    </a>
                    <div
                            class="collapse"
                            id="collapsePages"
                            aria-labelledby="headingTwo"
                            data-bs-parent="#sidenavAccordion"
                    >
                        <nav
                                class="sb-sidenav-menu-nested nav accordion"
                                id="sidenavAccordionPages"
                        >
                            <a
                                    class="nav-link collapsed"
                                    href="#"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#pagesCollapseAuth"
                                    aria-expanded="false"
                                    aria-controls="pagesCollapseAuth"
                            >
                                문서작성
                                <div class="sb-sidenav-collapse-arrow">
                                    <i class="fas fa-angle-down"></i>
                                </div>
                            </a>
                            <div
                                    class="collapse"
                                    id="pagesCollapseAuth"
                                    aria-labelledby="headingOne"
                                    data-bs-parent="#sidenavAccordionPages"
                            >
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a
                                            class="nav-link"
                                            href="/docTemplete/list"
                                    >서류 종류</a
                                    >
                                    <a
                                            class="nav-link"
                                            href="/tempDoc/list"
                                    >임시저장</a
                                    >
                                </nav>
                            </div>
                            <a
                                    class="nav-link collapsed"
                                    href="#"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#pagesCollapseError"
                                    aria-expanded="false"
                                    aria-controls="pagesCollapseError"
                            >
                                보관함
                                <div class="sb-sidenav-collapse-arrow">
                                    <i class="fas fa-angle-down"></i>
                                </div>
                            </a>
                            <div
                                    class="collapse"
                                    id="pagesCollapseError"
                                    aria-labelledby="headingOne"
                                    data-bs-parent="#sidenavAccordionPages"
                            >
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a
                                            class="nav-link"
                                            href="/approval/list"
                                    >결재함</a
                                    >
                                    <a
                                            class="nav-link"
                                            href="/document/list"
                                    >발신함</a
                                    >
                                    <a
                                            class="nav-link"
                                            href="/referrer/list"
                                    >참조함</a
                                    >
                                </nav>
                            </div>
                        </nav>
                    </div>
                    <c:if
                            test="${member.role_id > 29 and member.role_id < 51}"
                    >
                        <a
                                class="nav-link collapsed"
                                href="/hr/list"
                                data-bs-target="#collapseHR"
                                aria-expanded="false"
                                aria-controls="collapseHR"
                        >
                            <div class="sb-nav-link-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            인사 관리
                            <div class="sb-sidenav-collapse-arrow">
                                <i class="fas fa-angle-down"></i>
                            </div>
                        </a>
                        <a
                                class="nav-link collapsed"
                                href="/tna/list"
                                data-bs-target="#collapseHR"
                                aria-expanded="false"
                                aria-controls="collapseHR"
                        >
                            <div class="sb-nav-link-icon">
                                <i class="fas fa-calendar"></i>
                            </div>
                            근태 관리
                            <div class="sb-sidenav-collapse-arrow">
                                <i class="fas fa-angle-down"></i>
                            </div>
                        </a>
                        <a
                                class="nav-link collapsed"
                                href="/department/departmentList"
                                data-bs-target="#collapseHR"
                                aria-expanded="false"
                                aria-controls="collapseHR"
                        >
                            <div class="sb-nav-link-icon">
                                <i class="fas fa-book-open"></i>
                            </div>
                            부서 관리
                            <div class="sb-sidenav-collapse-arrow">
                                <i class="fas fa-angle-down"></i>
                            </div>
                        </a>
                    </c:if>

                    <a
                            class="nav-link collapsed"
                            href="/board/list?id=1"
                            data-bs-target="#collapseHR"
                            aria-expanded="false"
                            aria-controls="collapseHR"
                    >
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        QnA
                        <div class="sb-sidenav-collapse-arrow">
                            <i class="fas fa-angle-down"></i>
                        </div>
                    </a>
                    <a
                            class="nav-link collapsed"
                            href="/board/list?id=3"
                            data-bs-target="#collapseHR"
                            aria-expanded="false"
                            aria-controls="collapseHR"
                    >
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        공지사항
                        <div class="sb-sidenav-collapse-arrow">
                            <i class="fas fa-angle-down"></i>
                        </div>
                    </a>
                    <a
                            class="nav-link collapsed"
                            href="/board/list?id=2"
                            data-bs-target="#collapseHR"
                            aria-expanded="false"
                            aria-controls="collapseHR"
                    >
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        익명게시판
                        <div class="sb-sidenav-collapse-arrow">
                            <i class="fas fa-angle-down"></i>
                        </div>
                    </a>
                    <a
                            class="nav-link collapsed"
                            href="/product/list"
                            data-bs-target="#collapseHR"
                            aria-expanded="false"
                            aria-controls="collapseHR"
                    >
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        구독서비스
                        <div class="sb-sidenav-collapse-arrow">
                            <i class="fas fa-angle-down"></i>
                        </div>
                    </a>
                    <!-- <div class="sb-sidenav-menu-heading">Addons</div>
                    <a class="nav-link" href="charts.html">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-chart-area"></i>
                        </div>
                        Charts
                    </a>
                    <a class="nav-link" href="tables.html">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-table"></i>
                        </div>
                        Tables
                    </a> -->
                </div>
            </div>
        </nav>
    </div>
    <div id="layoutSidenav_content">
        <main class="h-100">
            <c:import url="/WEB-INF/views/${page}.jsp"/>
            <div
                    class="toast-container position-absolute top-0 end-0 p-3"
            ></div>
            <button
                    type="button"
                    class="btn btn-primary position-fixed bottom-0"
                    id="messengerButton"
            >
                메신저
                <!-- <span
                    class="position-absolute top-0 start-100 translate-middle badge border border-light rounded-circle bg-danger p-2"
                    ><span class="visually-hidden"
                        >unread messages</span
                    ></span
                > -->
            </button>
            <div
                    class="position-fixed bottom-0 animate__animated d-flex d-none"
                    id="messenger"
            >
                <div class="d-flex sidebar flex-column pe-1">
                    <div class="closeButton ms-1 mb-3">
                        <button
                                type="button"
                                class="btn btn-danger"
                                id="closeMessengerButton"
                        >
                            x
                        </button>
                    </div>

                    <ul
                            class="nav flex-column align-items-center"
                            id="myTab"
                            role="tablist"
                    >
                        <li
                                class="nav-item mt-2 mb-4"
                                role="presentation"
                        >
                            <button
                                    class="nav-link text-muted active"
                                    id="home-tab"
                                    data-bs-toggle="tab"
                                    data-bs-target="#home"
                                    type="button"
                                    role="tab"
                                    aria-controls="home"
                                    aria-selected="true"
                            >
                                <i class="fas fa-user"></i>
                            </button>
                        </li>
                        <li
                                class="nav-item mt-3 mb-3"
                                role="presentation"
                        >
                            <button
                                    class="nav-link text-muted"
                                    id="messages-tab"
                                    data-bs-toggle="tab"
                                    data-bs-target="#messages"
                                    type="button"
                                    role="tab"
                                    aria-controls="messages"
                                    aria-selected="false"
                            >
                                <i class="fas fa-comment"></i>
                            </button>
                        </li>
                    </ul>
                </div>

                <div class="w-100" id="messengerBody">
                    <div class="p-3 d-flex justify-content-between">
                        <div class="fw-bold">메신저</div>
                        <div>
                            <input
                                    class="d-none"
                                    type="text"
                                    id="chatSearch"
                            />
                            <a href="#" id="chatSearchButton">
                                <i class="fas fa-search fw-lighter"></i>
                            </a>
                        </div>
                    </div>

                    <div
                            class="overflow-auto tab-content"
                            id="memberContainer"
                    >
                        <div class="tab-content">
                            <div
                                    class="tab-pane active"
                                    id="home"
                                    role="tabpanel"
                                    aria-labelledby="home-tab"
                            >
                                <div class="d-flex flex-row w-100 p-3">
                                    <img
                                            src="${member.avatar.name}"
                                            alt="avatar"
                                            class="d-flex align-self-center me-3 rounded-4"
                                            width="60"
                                            height="60"
                                    />
                                    <div class="d-flex flex-column">
                                        <p class="fw-bold mb-0">
                                            ${member.name}
                                        </p>
                                        <p class="small text-muted">
                                            ${ member.position.name }
                                        </p>
                                    </div>
                                </div>

                                <ul
                                        class="list-unstyled mb-0 w-100"
                                        id="messengerMemberList"
                                ></ul>
                            </div>
                            <div
                                    class="tab-pane"
                                    id="messages"
                                    role="tabpanel"
                                    aria-labelledby="messages-tab"
                            >
                                <ul
                                        class="list-unstyled mb-0 w-100"
                                        id="messageList"
                                ></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<div
        class="modal fade"
        id="profileModal"
        data-bs-backdrop="static"
        data-bs-keyboard="false"
        tabindex="-1"
        aria-labelledby="profileModal"
        aria-hidden="true"
>
    <div
            class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
    >
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="profileModal">
                    프로필
                </h1>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body" id="profileBody"></div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal"
                >
                    닫기
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"
></script>
<script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"
></script>
<script src="/resources/js/scripts.js"></script>
</body>
</html>
