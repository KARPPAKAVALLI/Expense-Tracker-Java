<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="iconTag.png">
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

                 <div class="nav-links">
                    <a href="Dashboard.jsp" class="nav-link merienda-custom-header light-green-shadow">Dashboard</a>
                    <a href="Income.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Income</a>
                    <a href="DeleteIncome.jsp" class="nav-link merienda-custom-header light-green-shadow">Delete Income</a>
                    <a href="Expense.jsp" class="nav-link merienda-custom-header light-green-shadow bg-success text-white">Add Expense</a>
                    <a href="DeleteExpense.jsp" class="nav-link merienda-custom-header light-green-shadow">Delete Expense</a>
                    <a href="ExpenseReport.jsp" class="nav-link merienda-custom-header light-green-shadow">View Report</a>
                </div>
                
              <div class="logout-container">
				    <a href="LogoutServlet" class="nav-link merienda-custom-header logout" style="display: flex;">
				        Logout 
				        <img src="images/logout.png" alt="Logout" style="width: 20px; height: 20px; margin-left: 5px;">
				    </a>
				</div>
              
            </div>
            
            <div class="col-lg-8 col-md-8 col-sm-12 right-grid light-green-shadow">
                 <h2 class="dashboard-heading merienda-custom-header text-center text-success">Add Expense</h2>
                 
                 <div class="row justify-content-center"> <!-- Bootstrap grid row and center alignment -->
    <div class="col-md-6"> <!-- Use col-md-6 for medium-sized form -->
        <form action="addExpense" method="POST" class="mt-5 spacing-row">
            <!-- Date -->
            <div class="mb-3">
                <label for="date" class="form-label merienda-custom-header">Date</label>
                <input type="date" class="form-control merienda-custom-header" id="date" name="date" required>
            </div>

            <!-- Categories Dropdown -->
            <div class="mb-3">
                <label for="category" class="form-label merienda-custom-header">Category</label>
                <select class="form-select merienda-custom-header" id="categoryName" name="categoryName" required>
                    <option value="" disabled selected>Select Category</option>
                    <option value="Food">Food</option>
                    <option value="Social Life">Social Life</option>
                    <option value="Transport">Transport</option>
                    <option value="Investment">Investment</option>
                    <option value="Household">Household</option>
                    <option value="Apparel">Apparel</option>
                    <option value="Beauty">Beauty</option>
                    <option value="Health">Health</option>
                    <option value="Education">Education</option>
                    <option value="Gift">Gift</option>
                    <option value="Other">Other</option>
                    
                    
                </select>
            </div>
            
           
            <!-- Amount -->
            <div class="mb-3">
                <label for="amount" class="form-label merienda-custom-header">Amount</label>
                <input type="number" class="form-control merienda-custom-header" id="amount" name="amount" required>
            </div>

            <!-- Description -->
            <div class="mb-3">
                <label for="source" class="form-label merienda-custom-header">Description</label>
                <textarea class="form-control merienda-custom-header" id="source" name="source" rows="3" required></textarea>
            </div>

            <!-- Submit Button -->
            <div class="d-flex justify-content-center mt-4">
                <button type="submit" class="btn btn-success w-50 align-items-center merienda-custom-header">Add Expense</button>
            </div>
        </form>
    </div>
</div>       
</div>
</div>
</div>
  
</body>