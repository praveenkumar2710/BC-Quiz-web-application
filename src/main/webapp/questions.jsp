<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Question" %>

<%
    List<Question> questions =
        (List<Question>) request.getAttribute("questions");

    Integer selectedTopicId =
        (Integer) request.getAttribute("selectedTopicId");
%>

<!DOCTYPE html>
<html>
<head>
    <title>BCQuiz | Question Management</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="text-center mb-4">Question Management (Admin)</h2>

    <!-- ADD QUESTIONS -->
    <div class="card mb-4 shadow-sm">
        <div class="card-body">

            <h5 class="card-title mb-3">Add Questions (Bulk)</h5>

            <% if (selectedTopicId == null) { %>

                <div class="alert alert-warning">
                    Please select a topic first to add questions.
                </div>

            <% } else { %>

                <form method="post"
                      action="<%= request.getContextPath() %>/questions">

                    <input type="hidden"
                           name="topicId"
                           value="<%= selectedTopicId %>">

                    <div class="mb-3">
                        <label class="form-label">
                            Paste Questions (one per line)
                        </label>

                        <textarea name="bulkQuestions"
                                  class="form-control"
                                  rows="6"
                                  placeholder="Question | OptionA | OptionB | OptionC | OptionD | CorrectOption (A/B/C/D)"
                                  required></textarea>
                    </div>

                    <button type="submit"
                            class="btn btn-success">
                        Add All Questions
                    </button>
                </form>

                <div class="mt-2 text-muted small">
                    Example: What is SQL?|DB|Table|Query|All|D
                </div>

            <% } %>

        </div>
    </div>

    <!-- QUESTIONS LIST -->
    <div class="card shadow-sm">
        <div class="card-body">

            <h5 class="card-title mb-3">Questions List</h5>

            <table class="table table-bordered table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th style="width:5%">ID</th>
                        <th>Question</th>
                        <th style="width:10%">Correct</th>
                        <th style="width:15%">Action</th>
                    </tr>
                </thead>

                <tbody>
                <% if (questions != null && !questions.isEmpty()) {
                       for (Question q : questions) { %>

                    <tr>
                        <td><%= q.getQuestionId() %></td>
                        <td><%= q.getQuestionText() %></td>
                        <td><%= q.getCorrectOption() %></td>
                        <td>
                            <a class="btn btn-sm btn-danger"
                               href="<%= request.getContextPath() %>/questions?topicId=<%= (selectedTopicId != null ? selectedTopicId : 0) %>&deleteId=<%= q.getQuestionId() %>"
                               onclick="return confirm('Delete this question?');">
                                Delete
                            </a>
                        </td>
                    </tr>

                <%   }
                   } else { %>

                    <tr>
                        <td colspan="4"
                            class="text-center text-muted">
                            No questions found
                        </td>
                    </tr>

                <% } %>
                </tbody>
            </table>

        </div>
    </div>

</div>

</body>
</html>