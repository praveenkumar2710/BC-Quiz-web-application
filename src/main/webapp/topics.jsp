<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Subject"%>
<%@ page import="com.model.Topic"%>

<%
    Topic editTopic = (Topic) request.getAttribute("editTopic");

    List<Subject> subjects =
        (List<Subject>) request.getAttribute("subjects");

    Integer selectedId =
        (Integer) request.getAttribute("selectedSubjectId");

    List<Topic> topics =
        (List<Topic>) request.getAttribute("topics");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>BCQuiz | Topic Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">

        <a class="navbar-brand fw-bold"
           href="<%= request.getContextPath() %>/subjects">
            🛡 Admin | BCQuiz
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
                       href="<%= request.getContextPath() %>/subjects">
                        Subjects
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

    <h2 class="text-center mb-4">Topic Management</h2>

    <!-- SUBJECT SELECT -->
    <form method="get"
          action="<%= request.getContextPath() %>/topics"
          class="mb-4">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <label class="form-label">Select Subject</label>
                <select name="subjectId"
                        class="form-select"
                        onchange="this.form.submit()">
                    <option value="">-- Select Subject --</option>

                    <%
                        if (subjects != null) {
                            for (Subject s : subjects) {
                    %>
                        <option value="<%= s.getSubjectId() %>"
                            <%= (selectedId != null && selectedId.equals(s.getSubjectId()))
                                    ? "selected" : "" %>>
                            <%= s.getSubjectName() %>
                        </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
        </div>
    </form>

    <!-- ADD / EDIT -->
    <%
        if (selectedId != null) {
    %>
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <h5 class="card-title">
                <%= (editTopic != null) ? "Edit Topic" : "Add Topic" %>
            </h5>

            <form method="post"
                  action="<%= request.getContextPath() %>/topics">

                <input type="hidden" name="subjectId"
                       value="<%= selectedId %>">

                <% if (editTopic != null) { %>
                    <input type="hidden" name="topicId"
                           value="<%= editTopic.getTopicId() %>">
                <% } %>

                <div class="row">
                    <div class="col-md-8">
                        <input type="text"
                               name="topicName"
                               class="form-control"
                               placeholder="Enter Topic Name"
                               value="<%= (editTopic != null)
                                            ? editTopic.getTopicName()
                                            : "" %>"
                               required>
                    </div>

                    <div class="col-md-4">
                        <button type="submit"
                                class="btn btn-<%= (editTopic != null)
                                                    ? "warning"
                                                    : "primary" %> w-100">
                            <%= (editTopic != null)
                                    ? "Update Topic"
                                    : "Add Topic" %>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <%
        }
    %>

    <!-- LIST -->
    <div class="card shadow-sm">
        <div class="card-body">
            <h5 class="card-title">Topics List</h5>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Topic Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (topics != null && !topics.isEmpty()) {
                        for (Topic t : topics) {
                %>
                    <tr>
                        <td><%= t.getTopicId() %></td>
                        <td><%= t.getTopicName() %></td>
                        <td>
                            <a class="btn btn-sm btn-warning"
                               href="<%= request.getContextPath() %>/topics?subjectId=<%= selectedId %>&editId=<%= t.getTopicId() %>">
                                Edit
                            </a>

                            <a class="btn btn-sm btn-danger"
                               href="<%= request.getContextPath() %>/topics?subjectId=<%= selectedId %>&deleteId=<%= t.getTopicId() %>"
                               onclick="return confirm('Delete this topic?');">
                                Delete
                            </a>

                            <a class="btn btn-sm btn-outline-primary"
                               href="<%= request.getContextPath() %>/questions?topicId=<%= t.getTopicId() %>">
                                Manage Questions
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="3" class="text-center text-muted">
                            No topics found
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