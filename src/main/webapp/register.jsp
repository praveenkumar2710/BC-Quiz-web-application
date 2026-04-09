<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Registration | BCQuiz</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1f1c2c, #928dab);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-card {
            width: 100%;
            max-width: 520px;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(18px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            color: #fff;
        }

        .form-control {
            border-radius: 12px;
            padding-left: 40px;
            background: rgba(255,255,255,0.15);
            border: none;
            color: #fff;
        }

        .form-control::placeholder {
            color: rgba(255,255,255,0.7);
        }

        .form-control:focus {
            background: rgba(255,255,255,0.25);
            box-shadow: 0 0 0 2px rgba(255,255,255,0.4);
            color: #fff;
        }

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            color: #fff;
        }

        .btn-register {
            border-radius: 12px;
            padding: 12px;
            font-weight: 500;
            background: linear-gradient(135deg, #ff512f, #dd2476);
            border: none;
            transition: 0.3s ease;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
        }

        .server-error {
            color: #ffcccc;
            text-align: center;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .client-error {
            color: #ffd966;
            text-align: center;
            margin-bottom: 10px;
            font-size: 14px;
        }

        a {
            color: #fff;
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="register-card">

    <div class="text-center mb-4">
        <h3>Create Your Account</h3>
        <p>Join BCQuiz and start your journey 🚀</p>
    </div>

    <!-- SERVER ERROR -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="server-error"><%= error %></div>
    <%
        }
    %>

    <!-- CLIENT ERROR -->
    <div id="clientError" class="client-error"></div>

    <form method="post" action="<%= request.getContextPath() %>/register" onsubmit="return validateForm()">

        <div class="row">
            <div class="col-md-6 mb-3 input-icon">
                <i class="bi bi-person"></i>
                <input type="text" name="firstName" id="firstName"
                       class="form-control"
                       placeholder="First Name"
                       value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>"
                       required>
            </div>

            <div class="col-md-6 mb-3 input-icon">
                <i class="bi bi-person"></i>
                <input type="text" name="lastName" id="lastName"
                       class="form-control"
                       placeholder="Last Name"
                       value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>"
                       required>
            </div>
        </div>

        <div class="mb-3 input-icon">
            <i class="bi bi-envelope"></i>
            <input type="email" name="email" id="email"
                   class="form-control"
                   placeholder="Email Address"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                   required>
        </div>

        <div class="mb-3 input-icon">
            <i class="bi bi-phone"></i>
            <input type="tel" name="phone" id="phone"
                   class="form-control"
                   placeholder="Phone Number"
                   value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                   required>
        </div>

        <!-- DO NOT refill password for security -->
        <div class="mb-3 input-icon">
            <i class="bi bi-lock"></i>
            <input type="password" name="password" id="password"
                   class="form-control"
                   placeholder="Password" required>
        </div>

        <div class="mb-4 input-icon">
            <i class="bi bi-shield-lock"></i>
            <input type="password" name="confirmPassword" id="confirmPassword"
                   class="form-control"
                   placeholder="Confirm Password" required>
        </div>

        <button type="submit" class="btn btn-register w-100">
            Register
        </button>
    </form>

    <div class="text-center mt-4">
        <small>
            Already have an account?
            <a href="login.jsp">Login here</a>
        </small>
    </div>

</div>

<script>
function validateForm() {

    let nameRegex = /^[A-Za-z]+$/;
    let phoneRegex = /^[0-9]{10}$/;
    let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

    let firstName = document.getElementById("firstName");
    let lastName = document.getElementById("lastName");
    let phone = document.getElementById("phone");
    let password = document.getElementById("password");
    let confirmPassword = document.getElementById("confirmPassword");
    let errorDiv = document.getElementById("clientError");

    errorDiv.innerText = "";

    if (!nameRegex.test(firstName.value.trim())) {
        errorDiv.innerText = "First name should contain only letters.";
        return false;
    }

    if (!nameRegex.test(lastName.value.trim())) {
        errorDiv.innerText = "Last name should contain only letters.";
        return false;
    }

    if (!phoneRegex.test(phone.value.trim())) {
        errorDiv.innerText = "Phone number must be exactly 10 digits.";
        return false;
    }

    if (!passwordRegex.test(password.value)) {
        errorDiv.innerText = "Password must contain 8+ chars, uppercase, lowercase, number & special character.";
        return false;
    }

    if (password.value !== confirmPassword.value) {
        errorDiv.innerText = "Passwords do not match.";
        return false;
    }

    return true;
}
</script>

</body>
</html>