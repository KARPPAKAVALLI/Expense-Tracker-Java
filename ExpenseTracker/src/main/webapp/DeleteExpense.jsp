<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="images/iconTag.png">
    <title>Panam Pathiv</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
     <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="styles/dashboard.css">
</head>
<body>
	<%
	//telling browser to not cache this pg
	//Reason: since, "TO PREVENT BACK BUTTON"
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	//Preventing Back Button from Reloading Previously Typed Data
	response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    // Check if 'userid' session attribute is set
    if(session.getAttribute("userid") == null){
        // Redirect to login page if 'userid' is not found in session
        response.sendRedirect("Login.jsp");
    }
	%>
	<%
	    String message = (String) request.getAttribute("message");
	    if (message != null) {
	%>
    	<p style="color: green;"><%= message %></p>
	<%
    	}
	%>
	
	<div class="container-fluid">
        <div class="row">
            
           <div class="col-lg-3 col-md-4 col-sm-12 left-grid light-green-shadow"> 
                <p class="welcome-message merienda-custom-header text-success spacing-row" style="font-weight:bold; text-align: center; font-size: 30px">
    				Welcome, <%= session.getAttribute("username") %>!
				</p>
                <div class="nav-links" style="margin-top : 10px;">
                    <a href="Dashboard.jsp" class="nav-link merienda-custom-header light-green-shadow">Dashboard</a>
                    <a href="Income.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Income</a>
                    <a href="DeleteIncome.jsp" class="nav-link merienda-custom-header light-green-shadow">Delete Income</a>
                    <a href="Expense.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Expense</a>
                    <a href="DeleteExpense.jsp" class="nav-link merienda-custom-header light-green-shadow bg-success text-white">Delete Expense</a>
                    <a href="ExpenseReport.jsp" class="nav-link merienda-custom-header light-green-shadow">View Report</a>
                </div>
                <div class="logout-container">
				    <a href="logoutServlet" class="nav-link merienda-custom-header logout" style="display: flex;">
				        Logout 
				        <img src="images/logout.png" alt="Logout" style="width: 20px; height: 20px; margin-left: 5px;">
				    </a>
				</div>
            </div>
            
           <div class="col-lg-8 col-md-8 col-sm-12 right-grid light-green-shadow">
    <h2 class="dashboard-heading merienda-custom-header text-center text-success">Delete Expense</h2>

    <!-- Center the form horizontally and vertically within the grid -->
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 60vh;"> <!-- Flexbox centering -->
        <div class="col-md-6">
            <form action="deleteExpense" method="POST">
                <div class="mb-3">
                    <label for="date" class="form-label merienda-custom-header">Select Date</label>
                    <input type="date" class="form-control merienda-custom-header" id="date" name="date" required>
                </div>
                <div class="d-flex justify-content-center">
                    <button type="submit" class="btn btn-success merienda-custom-header">Fetch Expense</button>
                </div>
            </form>
        </div>
    </div>
</div>
           
        </div>
    </div>
	
</body>
</html>