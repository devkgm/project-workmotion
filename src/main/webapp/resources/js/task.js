const projectInfo = document.getElementsByClassName("projectInfo")[0];
const project_id = projectInfo.getAttribute("data-bs-projectId");
const crewList = document.getElementById("crewList");

function createCrewList(crewList) {
    let html = "";
    for (crew of crewList) {
        html += `
                    <button
                    class="list-group-item list-group-item-action"
                    data-bs-toggle="modal"
                    data-bs-target="#profileModal"
                    data-bs-memberId="${crew.id}"
                    onclick="createProfile(${crew.id})"
                    >
                        <div
                            class="d-flex align-items-center pb-1"
                            id="tooltips-container"
                        >
                            <img
                                src="https://bootdey.com/img/Content/avatar/avatar5.png"
                                class="rounded-circle img-fluid avatar-md img-thumbnail bg-transparent"
                                alt=""
                            />
                            <div class="w-100 ms-2">
                                <h5 class="mb-1">
                                    ${crew.name}<i
                                        class="mdi mdi-check-decagram text-info ms-1"
                                    ></i>
                                </h5>
                                <p
                                    class="mb-0 font-13 text-muted"
                                >
                                    ${crew.position.name}
                                </p>
                            </div>
                            <i
                                class="mdi mdi-chevron-right h2"
                            ></i>
                        </div>
                    </button>
            `;
    }
    return html;
}
function createMemberList(memberList) {
    let html = "";
    for (member of memberList) {
        html += `
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="member_id" value="${member.id}">
                    <div class="memberCard">
                        <div class="avatar">
                        </div>
                        <div class="info">
                            <div class="name">${member.name}</div>
                            <div class="role">${member.position.name}</div>
                        </div>
                    </div>
                </div>
            `;
    }
    return html;
}
async function loadCrewList() {
    const response = await fetch(`/v1/projects/${project_id}/crews`);
    const data = await response.json();
    crewList.innerHTML = createCrewList(data);
}
//loadCrewList();

//멤버 추가
const addCrewButton = document.getElementById("addCrewButton");
const submitButton = document.getElementById("submitButton");
const settingProjectButton = document.getElementById("settingProjectButton");
addCrewButton.addEventListener("click", async function () {
    const modalBody = document.getElementById("modalBody");
    modalBody.innerHTML = "";
    const response = await fetch(`/v1/projects/${project_id}/members`);
    const data = await response.json();

    let html = "<form id='frm'>";
    html += createMemberList(data);
    html += "</form>";
    modalBody.innerHTML = html;
});

submitButton.addEventListener("click", function () {
    const checked = document.querySelectorAll(
        "#modalBody input[type=checkbox]:checked"
    );
    let addMembers = [];
    const formData = new FormData();
    for (let i = 0; i < checked.length; i++) {
        const member_id = checked[i].value;
        addMembers.push(member_id);
    }
    formData.append("member_ids", addMembers.join(","));
    fetch(`/v1/projects/${project_id}/crews`, {
        method: "POST",
        body: formData,
    })
        .then((response) => response.json())
        .then((datas) => {
            console.log(datas);
            loadCrewList();
        });
});

async function loadProfile(member_id) {
    const response = await fetch(
        `/v1/projects/${project_id}/crews/` + member_id
    );
    const data = await response.json();
    return data;
}

async function createProfile(member_id) {
    const profileBody = document.getElementById("profileBody");
    profileBody.innerHTML = "";
    const member = await loadProfile(member_id);
    profileBody.innerHTML = `
        <div class="card">
            <div class="card-body">
                <div class="d-flex align-items-start">
                    <img
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                        class="rounded-circle avatar-lg img-thumbnail"
                        alt="profile-image"
                    />
                    <div class="w-100 ms-3">
                        <h4 class="my-0">${member.name}</h4>
                        <p class="text-muted">${member.position.name}</p>
                        <button
                            type="button"
                            class="btn btn-soft-success btn-xs waves-effect mb-2 waves-light"
                        >
                            메시지
                        </button>
                    </div>
                </div>
                <div class="mt-3">
                    <p class="text-muted mb-2 font-13">
                        <strong>전화번호 :</strong
                        ><span class="ms-2">${member.phone}</span>
                    </p>
                    <p class="text-muted mb-2 font-13">
                        <strong>이메일 :</strong>
                        <span class="ms-2">${member.email}</span>
                    </p>
                </div>
            </div>
        </div>
    `;
}

const submitArticleButton = document.getElementById("submitArticleButton");
const articleForm = document.getElementById("articleForm");

submitArticleButton.addEventListener("click", async function () {
    const formData = new FormData(articleForm);
    const response = await fetch(`/v1/projects/${project_id}/articles`, {
        method: "POST",
        body: formData,
    });
    const data = await response.json();
    articleForm.reset();
    loadArticle();
});

async function loadArticle() {
    const response = await fetch(`/v1/projects/${project_id}/articles`);
    const data = await response.json();
    const article = document.getElementById("article");
    article.innerHTML = createArticle(data).join("");
}
loadArticle();

async function deleteArticle(id) {
    if (confirm("삭제하시겠습니까?")) {
        const article = document.querySelector(
            `.taskArticle[data-bs-id='${id}']`
        );
        const response = await fetch(
            `/v1/projects/${project_id}/articles/` + id,
            { method: "delete" }
        );
        const data = await response.json();
        article.remove();
    }
}

function createArticle(datas) {
    return datas.map((article) => {
        return `
        <div class='border border-light shadow p-2 mb-3 taskArticle' data-bs-id=${
            article.id
        }>
            <div class='d-flex align-items-start'>
                <img
                    class='me-2 avatar-sm rounded-circle'
                    src='https://bootdey.com/img/Content/avatar/avatar3.png'
                    alt='Generic placeholder image'
                />
                <div class='w-100'>
                    <h5 class='m-0'>${article.writer.name}</h5>
                    <p class='text-muted'>
                        <small>${new Date(article.create_dt).toLocaleString(
                            "ko-KR"
                        )}</small>
                    </p>
                </div>
                <div class="dropdown float-end">
                    <a
                        href="#"
                        class="dropdown-toggle arrow-none card-drop"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                    >
                        <i class="mdi mdi-dots-vertical"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end">
                        <!-- item-->
                        <a
                            href="javascript:void(0);"
                            class="dropdown-item"
                            >수정하기</a
                        >
                        <!-- item-->
                        <a
                            href="javascript:void(0); deleteArticle(${
                                article.id
                            });"
                            class="dropdown-item"
                            >삭제하기</a
                        >
                    </div>
                </div>
            </div>
            ${article.content}
            <div class='mt-2'>
                <a href='javascript: void(0);' class='btn btn-sm btn-link text-muted'>
                    <i class='mdi mdi-reply'></i> Reply
                </a>
                <a href='javascript: void(0);' class='btn btn-sm btn-link text-muted'>
                    <i class='mdi mdi-heart-outline'></i>
                    Like
                </a>
                <a href='javascript: void(0);' class='btn btn-sm btn-link text-muted'>
                    <i class='mdi mdi-share-variant'></i>
                    Share
                </a>
            </div>
        </div>
        `;
    });
}

const homeButton = document.getElementById("homeButton");
const taskButton = document.getElementById("taskButton");

async function loadTask() {
    const response = await fetch(`/v1/projects/${project_id}/tasks`);
    const data = await response.json();
    const task = document.getElementById("task");
    task.innerHTML = createTask(data).join("");

    const changeStatus = document.getElementsByClassName("changeStatus");
    for (let i = 0; i < changeStatus.length; i++) {
        changeStatus[i].addEventListener("click", async function (e) {
            const selectedEl = e.target.parentElement.parentElement;
            const taskId = selectedEl.getAttribute("data-bs-taskId");
            const selectedValue = e.target.innerText;
            const statusButton = document.querySelector(
                `.status[data-bs-taskId='${taskId}']`
            );
            if (statusButton.innerText != selectedValue) {
                const value = selectedValue == "완료" ? 1 : 0;
                const response = await fetch(
                    `/v1/projects/${project_id}/tasks/${taskId}/status`,
                    {
                        method: "PUT",
                        body: JSON.stringify({ status: value }),
                        headers: {
                            "Content-Type": "application/json",
                        },
                    }
                );
                const data = await response.json();
                if (data == 1) {
                    statusButton.innerText = selectedValue;
                    statusButton.classList.toggle("text-bg-primary");
                    statusButton.classList.toggle("text-bg-success");
                }
            }
        });
    }
}
const status = { 0: "진행", 1: "완료" };
function createTask(tasks) {
    return tasks.map((task) => {
        console.log(task);
        return `
        <div class='border border-light shadow p-2 mb-3 taskArticle' data-bs-id=${
            task.id
        }>
            <div class='d-flex align-items-start'>
                <img
                    class='me-2 avatar-sm rounded-circle'
                    src='https://bootdey.com/img/Content/avatar/avatar3.png'
                    alt='Generic placeholder image'
                />
                
                <div class='w-100'>
                    <h5 class='m-0'>${task.writer.name}</h5>
                    <p class='text-muted'>
                        <small>${new Date(task.create_dt).toLocaleString(
                            "ko-KR"
                        )}</small>
                    </p>
                </div>
                <div class='float-end'>
                    <div class="dropdown">
                    <h3 class='m-0'>
                    ${
                        task.status == 0
                            ? `
                        <a class="btn badge rounded-pill text-bg-primary status" data-bs-taskId="${
                            task.id
                        }" data-bs-toggle="dropdown" aria-expanded="false">${
                                  status[task.status]
                              }</a> 
                        `
                            : `
                        <a class="btn badge rounded-pill text-bg-success status" data-bs-taskId="${
                            task.id
                        }" data-bs-toggle="dropdown" aria-expanded="false">${
                                  status[task.status]
                              }</a> 
                        `
                    }
                    <ul class="dropdown-menu" data-bs-taskId="${task.id}">
                        <li><button class="dropdown-item changeStatus" type="button">완료</button></li>
                        <li><button class="dropdown-item changeStatus" type="button">진행</button></li>
                    </ul>
                    </h3>
                    
                    
                  
                    </div>
                </div>
                <div class="dropdown float-end">
                    <a
                        href="#"
                        class="dropdown-toggle arrow-none card-drop"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                    >
                        <i class="mdi mdi-dots-vertical"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end">
                        <!-- item-->
                        <a
                            href="javascript:void(0);"
                            class="dropdown-item"
                            >수정하기</a
                        >
                        <!-- item-->
                        <a
                            href="javascript:void(0); deleteTask(${task.id});"
                            class="dropdown-item"
                            >삭제하기</a
                        >
                    </div>
                </div>
            </div>
            <div class='mb-3'>
                    <h3 class='m-0'>${task.name}</h3>
            </div>
            ${
                task.start_dt != null && task.end_dt != null
                    ? `
                <div class="mb-3">
                    <h6 class='m-0'>일정</h6>
                    <small>시작일: ${new Date(task.start_dt).toLocaleString(
                        "ko-KR"
                    )}</small><br>
                    <small>종료일: ${new Date(task.end_dt).toLocaleString(
                        "ko-KR"
                    )}</small><br>
                </div>
                `
                    : ""
            }
            
            ${
                task.task_member.length > 0
                    ? `
                <div class="mb-3">
                <h6 class='m-0'>담당자</h6>
                <small>${task.task_member
                    .map(
                        (member) =>
                            `<span class="badge text-bg-primary">${member.name}</span>`
                    )
                    .join(" ")}</small><br>
              
                </div>`
                    : ""
            }
            
            
            ${task.content}
            <div class='mt-2'>
                <a href='javascript: void(0);' class='btn btn-sm btn-link text-muted'>
                    <i class='mdi mdi-reply'></i> Reply
                </a>
                <a href='javascript: void(0);' class='btn btn-sm btn-link text-muted'>
                    <i class='mdi mdi-heart-outline'></i>
                    Like
                </a>
                <a href='javascript: void(0);' class='btn btn-sm btn-link text-muted'>
                    <i class='mdi mdi-share-variant'></i>
                    Share
                </a>
            </div>
        </div>
        `;
    });
}

taskButton.addEventListener("click", function () {
    console.log("Task clicked");
    loadTask();
});

async function deleteTask(id) {
    if (confirm("삭제하시겠습니까?")) {
        const task = document.querySelector(`.taskArticle[data-bs-id='${id}']`);
        const response = await fetch(`/v1/projects/${project_id}/tasks/` + id, {
            method: "delete",
        });
        const data = await response.json();
        if (data == 1) {
            alert("삭제 되었습니다.");
            task.remove();
        } else {
            alert("삭제 실패했습니다.");
        }
    }
}

const scaduleButton = document.getElementById("scaduleButton");

//이거 없으면 초기 화면 렌더링 이상함
scaduleButton.addEventListener("click", () => {
    const prev = document.querySelector("button[aria-label='prev']");
    const next = document.querySelector("button[aria-label='next']");
    prev.click();
    next.click();
});
document.addEventListener("DOMContentLoaded", () => {
    // calendar element 취득
    var calendarEl = $("#calendar")[0];
    // full-calendar 생성하기
    var calendar = new FullCalendar.Calendar(calendarEl, {
        height: "700px", // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: "08:00", // Day 캘린더에서 시작 시간
        slotMaxTime: "20:00", // Day 캘린더에서 종료 시간
        // 해더에 표시할 툴바
        headerToolbar: {
            left: "prev,next today",
            center: "title",
            right: "dayGridMonth,timeGridWeek,timeGridDay,listWeek",
        },
        initialView: "dayGridMonth", // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: "ko", // 한국어 설정
        eventAdd: function (obj) {
            // 이벤트가 추가되면 발생하는 이벤트
            console.log(obj);
        },
        eventChange: function (obj) {
            // 이벤트가 수정되면 발생하는 이벤트
            console.log(obj);
        },
        eventRemove: function (obj) {
            // 이벤트가 삭제되면 발생하는 이벤트
            console.log(obj);
        },
        select: function (arg) {
            // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
            var title = prompt("Event Title:");
            if (title) {
                calendar.addEvent({
                    title: title,
                    start: arg.start,
                    end: arg.end,
                    allDay: arg.allDay,
                });
            }
            calendar.unselect();
        },
        eventClick: function (info) {
            const calandarModalEl = document.getElementById("calandarModal");
            const myModal = new bootstrap.Modal(calandarModalEl);
            myModal.show();
            // or
            function deleteEvent() {
                if (
                    confirm(
                        "'" + info.event.title + " 일정을 삭제하시겠습니까 ?"
                    )
                ) {
                    // 확인 클릭 시
                    info.event.remove();
                }
            }
            function removeAllEventListeners(element) {
                var clone = element.cloneNode(true);
                element.parentNode.replaceChild(clone, element);
                clone.addEventListener("click", deleteEvent);
            }
            const deleteEventButton =
                document.getElementById("deleteEventButton");

            removeAllEventListeners(deleteEventButton);
            // console.log(info.event);
            var events = new Array(); // Json 데이터를 받기 위한 배열 선언
            var obj = new Object();
            obj.title = info.event._def.title;
            obj.start = info.event._instance.range.start;
            obj.end = info.event._instance.range.end;
            events.push(obj);
            const calandarModalBody =
                document.getElementById("calandarModalBody");
            console.log(events[0].title);
            calandarModalBody.innerHTML = `
                    <div>
                        <h5>${events[0].title}</h5>
                        <p>시작: ${new Date(events[0].start).toLocaleString(
                            "ko-KR"
                        )}</p>
                        <p>종료: ${new Date(events[0].end).toLocaleString(
                            "ko-KR"
                        )}</p>
                    </div>
                `;

            // console.log(events);
            // $(function deleteData() {
            //     $.ajax({
            //         url: "/full-calendar/calendar-admin-update",
            //         method: "DELETE",
            //         dataType: "json",
            //         data: JSON.stringify(events),
            //         contentType: "application/json",
            //     });
            // });
        },
        // 이벤트
        events: [
            {
                id: "hello",
                title: "All Day Event",
                start: "2024-02-01",
                end: "2024-02-03",
            },
            {
                title: "Long Event",
                start: "2024-02-07",
                end: "2024-02-10",
            },
            {
                groupId: 999,
                title: "Repeating Event",
                start: "2024-02-09T16:00:00",
            },
            {
                groupId: 999,
                title: "Repeating Event",
                start: "2024-02-16T16:00:00",
            },
            {
                title: "Conference",
                start: "2024-02-11",
                end: "2024-02-13",
            },
            {
                title: "Meeting",
                start: "2024-02-12T10:30:00",
                end: "2024-02-12T12:30:00",
            },
            {
                title: "Lunch",
                start: "2024-02-12T12:00:00",
            },
            {
                title: "Meeting",
                start: "2024-02-12T14:30:00",
            },
            {
                title: "Happy Hour",
                start: "2024-02-12T17:30:00",
            },
            {
                title: "Dinner",
                start: "2024-02-12T20:00:00",
            },
            {
                title: "Birthday Party",
                start: "2024-02-13T07:00:00",
            },
            {
                title: "Click for Google",
                url: "http://google.com/", // 클릭시 해당 url로 이동
                start: "2024-02-28",
            },
        ],
    });
    // 캘린더 랜더링
    calendar.render();
});

//summernote init
$("#summernote").summernote({
    placeholder: "내용을 입력해주세요.",
    tabsize: 4,
    height: 150,
    toolbar: [
        ["style", ["style"]],
        ["font", ["bold", "underline", "clear"]],
        ["color", ["color"]],
        ["para", ["ul", "ol", "paragraph"]],
        ["table", ["table"]],
        ["insert", ["link", "picture", "video"]],
    ],
});