<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>BCQuiz | Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            border-radius: 20px;
            border: none;
            box-shadow: 0 25px 60px rgba(0,0,0,0.2);
            backdrop-filter: blur(15px);
        }

        .login-title {
            font-weight: 600;
            color: #1f2937;
        }

        .form-control {
            padding: 14px;
            border-radius: 12px;
        }

        .login-btn {
            padding: 12px;
            border-radius: 14px;
            background: linear-gradient(45deg, #6366f1, #4f46e5);
            border: none;
        }

        .link {
            color: #6366f1;
            text-decoration: none;
        }

        .password-wrapper {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            cursor: pointer;
        }

        .card {
            background: rgba(255,255,255,0.95);
        }
    </style>
</head>

<body>

<div class="col-md-4 col-sm-8">

    <div class="card login-card">
        <div class="card-body p-5">

            <h3 class="text-center mb-4 login-title">Welcome Back</h3>

            <!-- ERROR MESSAGE -->
            <c:if test="${not empty error}">
                <p class="text-danger text-center mb-3">${error}</p>
            </c:if>

            <form method="post" action="<%= request.getContextPath() %>/login" id="loginForm">

                <div class="mb-4">
                    <label class="form-label">Email</label>
                    <input type="email"
                           class="form-control"
                           name="email"
                           placeholder="you@example.com"
                           required>
                </div>

                <div class="mb-4 password-wrapper">
                    <label class="form-label">Password</label>
                    <input type="password"
                           class="form-control"
                           name="password"
                           id="password"
                           placeholder="password"
                           required>
                    <i class="bi bi-eye toggle-password" id="togglePassword"></i>
                </div>

                <button type="submit"
                        class="btn btn-primary w-100 login-btn"
                        id="loginBtn">
                    Login
                </button>
            </form>

            <hr class="my-4">

            <p class="text-center mb-0">
                New user?
                <a href="<%= request.getContextPath() %>/register.jsp" class="link">Create an account</a>
            </p>

        </div>
    </div>

</div>

<script>
const togglePassword = document.getElementById("togglePassword");
const password = document.getElementById("password");

togglePassword.addEventListener("click", function () {
    const type = password.type === "password" ? "text" : "password";
    password.type = type;
    this.classList.toggle("bi-eye-slash");
});

const form = document.getElementById("loginForm");
const loginBtn = document.getElementById("loginBtn");

form.addEventListener("submit", function () {
    loginBtn.innerHTML = 'Logging in...';
    loginBtn.disabled = true;
});
</script>

</body>
</html>