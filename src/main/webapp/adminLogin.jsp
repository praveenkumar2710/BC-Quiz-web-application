<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>BCQuiz | Admin Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

<style>
body {
    min-height: 100vh;
    font-family: 'Inter', sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(-45deg, #1e3a8a, #2563eb, #4f46e5, #1e40af);
    background-size: 400% 400%;
    animation: gradientBG 12s ease infinite;
}

@keyframes gradientBG {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

.login-wrapper {
    width: 100%;
    max-width: 420px;
}

.login-card {
    border-radius: 18px;
    border: none;
    backdrop-filter: blur(15px);
    background: rgba(255,255,255,0.95);
    box-shadow: 0 30px 60px rgba(0,0,0,0.25);
}

.brand {
    font-weight: 600;
    font-size: 18px;
    color: #1e3a8a;
}

.subtitle {
    font-size: 14px;
    color: #6b7280;
}

.form-control {
    border-radius: 12px;
    padding: 12px 14px;
}

.login-btn {
    padding: 12px;
    border-radius: 12px;
    background: linear-gradient(45deg, #2563eb, #4f46e5);
    border: none;
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

.error {
    font-size: 14px;
    color: #dc2626;
    text-align: center;
    margin-bottom: 12px;
}

.back-link {
    font-size: 14px;
    text-decoration: none;
    color: #2563eb;
}
</style>

</head>

<body>

<div class="login-wrapper">

    <div class="card login-card">
        <div class="card-body p-5">

            <div class="text-center mb-4">
                <div class="brand">BCQuiz — Admin</div>
                <div class="subtitle">Sign in to manage content</div>
            </div>

            <!-- ERROR -->
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form method="post" action="<%= request.getContextPath() %>/adminLogin" id="adminForm">

                <div class="mb-4">
                    <label class="form-label">Email</label>
                    <input type="email"
                           name="email"
                           class="form-control"
                           placeholder="admin@bcquiz.com"
                           required>
                </div>

                <div class="mb-4 password-wrapper">
                    <label class="form-label">Password</label>
                    <input type="password"
                           name="password"
                           id="password"
                           class="form-control"
                           placeholder="password"
                           required>
                    <i class="bi bi-eye toggle-password" id="togglePassword"></i>
                </div>

                <button type="submit"
                        class="btn btn-dark w-100 login-btn"
                        id="loginBtn">
                    Login
                </button>
            </form>

            <hr class="my-4">

            <div class="text-center">
                <a href="<%= request.getContextPath() %>/index.jsp" class="back-link">
                    ← Back to Home
                </a>
            </div>

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

const form = document.getElementById("adminForm");
const loginBtn = document.getElementById("loginBtn");

form.addEventListener("submit", function () {
    loginBtn.innerHTML = 'Authenticating...';
    loginBtn.disabled = true;
});
</script>

</body>
</html>