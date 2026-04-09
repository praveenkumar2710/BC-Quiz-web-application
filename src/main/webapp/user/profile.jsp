<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.User" %>

<%
HttpSession session1 = request.getSession(false);
if (session1 == null || session1.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

User loggedUser = (User) session1.getAttribute("user");

List<Object[]> attempts = null;
Object obj = request.getAttribute("attempts");

if (obj != null && obj instanceof List) {
    attempts = (List<Object[]>) obj;
}

int totalAttempts = (attempts != null) ? attempts.size() : 0;
int totalScore = 0;

if (attempts != null) {
    for (Object[] row : attempts) {
        if (row[1] != null) {
            totalScore += (Integer) row[1];
        }
    }
}

double avgPercent = 0;
if (totalAttempts > 0) {
    avgPercent = ((double) totalScore / (totalAttempts * 15)) * 100;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>My Profile | BCQuiz</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(to right, #eef2f7, #e0ecff);
}

.navbar {
    background: linear-gradient(90deg, #4f46e5, #6366f1);
}

.profile-card {
    border-radius: 16px;
    background: white;
}

.stat-box {
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    color: white;
}

.stat1 { background: #6366f1; }
.stat2 { background: #22c55e; }

.progress {
    height: 20px;
    border-radius: 10px;
}

.badge-date {
    font-size: 13px;
    color: #6b7280;
}
</style>
</head>

<body>

<nav class="navbar navbar-dark px-4">
    <a class="navbar-brand fw-bold"
       href="<%= request.getContextPath() %>/user/subjects">
        BCQuiz Dashboard
    </a>

    <div class="text-white">
        👋 Welcome, <strong><%= loggedUser.getName() %></strong>
    </div>

    <a href="<%= request.getContextPath() %>/LogoutServlet"
       class="btn btn-light btn-sm">
       Logout
    </a>
</nav>

<div class="container mt-5">

    <div class="card shadow profile-card p-4 mb-4">
        <div class="row align-items-center">

            <div class="col-md-6">
                <h4 class="fw-bold">User Information</h4>
                <p><strong>Name:</strong> <%= loggedUser.getName() %></p>
                <p><strong>User ID:</strong> <%= loggedUser.getUserId() %></p>
            </div>

            <div class="col-md-6">
                <div class="row">
                    <div class="col-6">
                        <div class="stat-box stat1 shadow">
                            <h6>Total Attempts</h6>
                            <h3 id="totalAttempts">0</h3>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="stat-box stat2 shadow">
                            <h6>Average Score</h6>
                            <h3><span id="avgScore">0</span>%</h3>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="card shadow profile-card p-4">
        <h4 class="fw-bold mb-4">📊 Quiz Attempt History</h4>

        <div class="mb-3">
            <input type="text"
                   id="searchInput"
                   onkeyup="filterTable()"
                   class="form-control"
                   placeholder="🔍 Search by Topic...">
        </div>

        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>Topic</th>
                    <th>Score</th>
                    <th>Performance</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>

            <%
            if (attempts != null && !attempts.isEmpty()) {
                for (Object[] row : attempts) {

                    String topicName = (String) row[0];
                    int score = (row[1] != null) ? (Integer) row[1] : 0;
                    java.sql.Timestamp date = (java.sql.Timestamp) row[2];

                    int percent = (score * 100) / 15;

                    String progressColor =
                        percent >= 70 ? "bg-success" :
                        percent >= 40 ? "bg-warning" :
                        "bg-danger";
            %>

                <tr>
                    <td><strong><%= topicName %></strong></td>
                    <td><%= score %> / 15</td>

                    <td style="width:250px;">
                        <div class="progress">
                            <div class="progress-bar <%= progressColor %>"
                                 style="width: <%= percent %>%;">
                                <%= percent %>%
                            </div>
                        </div>
                    </td>

                    <td>
                        <span class="badge-date">
                            <%= date %>
                        </span>
                    </td>
                </tr>

            <%
                }
            } else {
            %>

                <tr>
                    <td colspan="4" class="text-center text-muted py-4">
                        🚀 You haven’t attempted any quizzes yet.
                    </td>
                </tr>

            <%
            }
            %>

            </tbody>
        </table>
    </div>

</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const bars = document.querySelectorAll(".progress-bar");

    bars.forEach(bar => {
        let width = bar.style.width;
        bar.style.width = "0%";

        setTimeout(() => {
            bar.style.transition = "width 1s";
            bar.style.width = width;
        }, 200);
    });
});

function animateValue(id, start, end, duration) {
    let obj = document.getElementById(id);
    if(end === 0){
        obj.innerHTML = 0;
        return;
    }

    let range = end - start;
    let current = start;
    let increment = end > start ? 1 : -1;
    let stepTime = Math.abs(Math.floor(duration / range));

    let timer = setInterval(function() {
        current += increment;
        obj.innerHTML = current;
        if (current == end) clearInterval(timer);
    }, stepTime);
}

document.addEventListener("DOMContentLoaded", function() {
    animateValue("totalAttempts", 0, <%= totalAttempts %>, 1000);
    animateValue("avgScore", 0, Math.floor(<%= avgPercent %>), 1000);
});

function filterTable() {
    let input = document.getElementById("searchInput").value.toLowerCase();
    let rows = document.querySelectorAll("tbody tr");

    rows.forEach(row => {
        if(row.cells.length > 0){
            let topic = row.cells[0].innerText.toLowerCase();
            row.style.display = topic.includes(input) ? "" : "none";
        }
    });
}

document.addEventListener("DOMContentLoaded", function() {
    let dates = document.querySelectorAll(".badge-date");

    dates.forEach(date => {
        let raw = new Date(date.innerText);
        date.innerText = raw.toLocaleString();
    });
});
</script>

</body>
</html>