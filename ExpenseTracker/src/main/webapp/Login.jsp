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
	<div class="container mt-25 light-green-shadow custom-val" style="border: 1px solid transparent; border-radius : 20px;">
        <div class="row justify-content-center">
            <div class="col-md-6 d-flex justify-content-center align-items-center">
                <img src="images/loginPic.jpg" alt="Login image" class="img-fluid w-75">
            </div>
            
            <div class="col-md-6">
                <h2 class="text-center mt-2 merienda-custom-header text-success spacing-row">Login</h2>
                <form action="login" method="POST" class="mt-4 spacing-row" onsubmit="return validateForm()">
                    <!-- Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label merienda-custom-header">Email id</label>
                        <input type="text" class="form-control merienda-custom-header" id="email" name="email" required oninput="validateEmail()">
                    	<div id="emailFeedback" style="color: red;"></div> <!-- Feedback Element -->
                    </div>
                    
                    <!-- Password -->
                    <div class="mb-3">
                        <label for="password" class="form-label merienda-custom-header">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required >
                    </div>
                    
                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-success w-50 align-items-center merienda-custom-header">Login</button>
                    </div>
                </form>
                <p class="mt-3 merienda-custom-header">Don't have an account? <a href="Register.jsp" class="text-success merienda-custom-header">Sign Up</a></p>
            </div>
        </div>
    </div>
    

<script>
	
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
	
	function validateForm() {
	    validateEmail(); // Check email when form is submitted
	
	    const emailFeedback = document.getElementById("emailFeedback").textContent;
	
	    return !emailFeedback; // Allow form submission only if no feedback is present
	}
</script>
</body>
</html>