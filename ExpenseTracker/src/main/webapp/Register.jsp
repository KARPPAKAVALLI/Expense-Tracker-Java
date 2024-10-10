<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" type="image/png" href="iconTag.png">
	<title>Panam Pathiv</title>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet">

 
    <link rel="stylesheet" href="styles/style.css">
    
</head>
<body>
	<!-- Check for an error message -->
    <c:if test="${not empty errorMessage}">
        <div style="color: red;">
            ${errorMessage}
        </div>
    </c:if>

	 <div class="container mt-5 light-green-shadow custom-size" style="border: 1px solid transparent;border-radius : 20px;">
	    <div class="row justify-content-center">
	        <div class="col-md-5 spacing-row">
	            <h2 class="text-center mt-2 merienda-custom-header text-success">Sign Up</h2>
	            <form id="userForm" action="register" method="POST" class="mt-4" onsubmit="return validateForm()"> 
	                <!-- Username -->
	                <div class="mb-3">
	                    <label for="username" class="form-label merienda-custom-header">Username</label>
	                    <input type="text" class="form-control w-70 merienda-custom-header" id="username" name="username" required>
	                </div>
	                
	                <!-- Email -->
	                <div class="mb-3">
	                    <label for="email" class="form-label merienda-custom-header">Email</label>
	                    <input type="email" class="form-control w-70 merienda-custom-header " id="email" name="email" required oninput = "validateEmail()">
	                	<span id="emailFeedback" style="color: red;"></span><br>
	                </div>
	                
	                <!-- Password -->
	                <div class="mb-3">
	                    <label for="password" class="form-label merienda-custom-header">Password</label>
	                    <input type="password" class="form-control w-70 merienda-custom-header " id="password" name="password" required oninput = "validatePassword()">
	                	<span id="passwordFeedback" style="color: red;"></span><br>
	                </div>
	                
	                
	                <!-- Phone Number -->
	                <div class="mb-3">
	                    <label for="phone" class="form-label merienda-custom-header">Phone Number</label>
	                    <input type="tel" class="form-control w-70 merienda-custom-header " id="phone" name="phone" required oninput = "validatePhone()">
	                	<span id="phoneFeedback" style="color: red;"></span><br>
	                </div>
	                
	                <!-- Submit Button -->
	                <div class="d-grid merienda-custom-header mt-10">
	                    <button type="submit" class="btn btn-success w-50 align-items-center merienda-custom-header" style="justify-content: center;">Sign Up</button>
	                </div>
	            </form>
	        </div>
	        
	        <div class="col-md-4 d-flex flex-column justify-content-center align-items-center pe-1"> 
	            <img src="images/signupImage.png" alt="Sign up image" class="img-fluid w-150">
	            <p class="mb-0 text-center mt-2 merienda-custom-header ">Already have an account? <a href="Login.jsp" class="text-success merienda-custom-header">SignIn</a></p>
	        </div>
	    </div>
	</div>
<script>
function validatePassword() {
    const password = document.getElementById("password").value;
    const feedback = document.getElementById("passwordFeedback");
    const minLength = 8;
    const hasUpperCase = /[A-Z]/.test(password);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    
    if (password.length < minLength || !hasUpperCase || !hasSpecialChar) {
        feedback.textContent = "Password must be at least 8 characters long, contain at least one uppercase letter, and one special character.";
    } else {
        feedback.textContent = "";
    }
}

function validateEmail() {
    const email = document.getElementById("email").value;
    const feedback = document.getElementById("emailFeedback");
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Simple email regex

    if (!emailPattern.test(email)) {
        feedback.textContent = "Please enter a valid email address.";
    } else {
        feedback.textContent = "";
    }
}

function validatePhone() {
    const phone = document.getElementById("phone").value;
    const feedback = document.getElementById("phoneFeedback");
    const phonePattern = /^(?:\+\d{1,3}[- ]?)?\d{10}$/; // Allow country code or 10-digit number

    if (!phonePattern.test(phone)) {
        feedback.textContent = "Please enter a valid phone number (10 digits or with country code).";
    } else {
        feedback.textContent = "";
    }
}

function validateForm() {
    validatePassword(); // Check password when form is submitted
    validateEmail(); // Check email when form is submitted
    validatePhone(); // Check phone when form is submitted

    const passwordFeedback = document.getElementById("passwordFeedback").textContent;
    const emailFeedback = document.getElementById("emailFeedback").textContent;
    const phoneFeedback = document.getElementById("phoneFeedback").textContent;

    return !passwordFeedback && !emailFeedback && !phoneFeedback; // Allow form submission only if no feedback is present
}
</script>

</body>
</html>