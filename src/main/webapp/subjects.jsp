<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Subject"%>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<%
    Subject editSubject = (Subject) request.getAttribute("editSubject");
    List<Subject> list = (List<Subject>) request.getAttribute("subjectList");
%>

<!DOCTYPE html>
<html>
<head>
<title>BCQuiz | Subject Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">

        <a class="navbar-brand fw-semibold" href="#">
            Admin Panel
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#adminNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link"
                       href="<%= request.getContextPath() %>/topics">
                        Topics
                    </a>
                </li>

            </ul>

            <a class="btn btn-outline-light btn-sm"
               href="<%= request.getContextPath() %>/LogoutServlet">
                Logout
            </a>

        </div>
    </div>
</nav>

<div class="container mt-5">

    <h2 class="text-center mb-4">Subject Management (Admin)</h2>

    <!-- ADD / EDIT -->
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <h5 class="card-title">
                <%= (editSubject != null) ? "Edit Subject" : "Add Subject" %>
            </h5>

            <form action="<%= request.getContextPath() %>/subjects" method="post">

                <% if (editSubject != null) { %>
                    <input type="hidden" name="subjectId"
                           value="<%= editSubject.getSubjectId() %>">
                <% } %>

                <div class="row">
                    <div class="col-md-8">
                        <input type="text"
                               name="subjectName"
                               class="form-control"
                               placeholder="Enter Subject Name"
                               value="<%= (editSubject != null) ? editSubject.getSubjectName() : "" %>"
                               required>
                    </div>

                    <div class="col-md-4">
                        <button type="submit"
                                class="btn btn-<%= (editSubject != null) ? "warning" : "primary" %> w-100">
                            <%= (editSubject != null) ? "Update Subject" : "Add Subject" %>
                        </button>
                    </div>
                </div>

            </form>
        </div>
    </div>

    <!-- LIST -->
    <div class="card shadow-sm">
        <div class="card-body">
            <h5 class="card-title">Subjects List</h5>

            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Subject Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (list != null && !list.isEmpty()) {
                        for (Subject s : list) {
                %>
                    <tr>
                        <td><%= s.getSubjectId() %></td>

                        <td>
                            <a class="text-decoration-none fw-semibold"
                               href="<%= request.getContextPath() %>/topics?subjectId=<%= s.getSubjectId() %>">
                                <%= s.getSubjectName() %>
                            </a>
                        </td>

                        <td>
                            <a class="btn btn-sm btn-outline-warning"
                               href="<%= request.getContextPath() %>/subjects?editId=<%= s.getSubjectId() %>">
                                Edit
                            </a>

                            <a class="btn btn-sm btn-outline-danger"
                               href="<%= request.getContextPath() %>/subjects?deleteId=<%= s.getSubjectId() %>"
                               onclick="return confirm('Delete this subject?');">
                                Delete
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="3" class="text-center text-muted">
                            No subjects found
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>