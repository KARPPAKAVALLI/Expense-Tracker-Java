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
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<%
	//telling browser to not cache this pg
	//Reason: since, "TO PREVENT BACK BUTTON"
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
    // Check if 'userid' session attribute is set
    if(session.getAttribute("userid") == null){
        // Redirect to login page if 'userid' is not found in session
        response.sendRedirect("Login.jsp");
    }
	%>
	
	<div class="container-fluid">
        <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-12 left-grid light-green-shadow"> 
            <p class="welcome-message merienda-custom-header text-success spacing-row" style="font-weight:bold; text-align: center; font-size: 30px">
    			Welcome, <%= session.getAttribute("username") %>!
			</p>
                
                <div class="nav-links" style="margin-top : 10px;">
                    <a href="Dashboard.jsp" class="nav-link merienda-custom-header light-green-shadow bg-success text-white">Dashboard</a>
                    <a href="Income.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Income</a>
                    <a href="DeleteIncome.jsp" class="nav-link merienda-custom-header light-green-shadow">Delete Income</a>
                    <a href="Expense.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Expense</a>
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
                <h2 class="dashboard-heading merienda-custom-header text-center text-success">Dashboard</h2>
                <div class="row">
                    <!-- First Card: Income -->
                    <div class="col-md-4">
                        <div class="card custom-card">
                            <div class="card-body text-center light-green-shadow">
                                <h5 class="card-title merienda-custom-header text-center" style="font-size: 25px;">Income</h5>
                                <p class="card-text merienda-custom-header text-center text-success" style="font-size: 22px;">
                                    <%= request.getAttribute("income") != null ?"Rs. "+ request.getAttribute("income") : "0.00" %>
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Second Card: Balance -->
                    <div class="col-md-4">
                        <div class="card custom-card">
                            <div class="card-body text-center light-green-shadow">
                                <h5 class="card-title merienda-custom-header text-center" style="font-size: 25px;">Balance</h5>
                                <p class="card-text merienda-custom-header text-center text-success" style="font-size: 22px;">
                                    <%= request.getAttribute("balance") != null ? "Rs. "+request.getAttribute("balance") : "0.00" %>
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Third Card: Expenditure  -->
                    <div class="col-md-4">
                        <div class="card custom-card">
                            <div class="card-body text-center light-green-shadow">
                                <h5 class="card-title merienda-custom-header text-center" style="font-size: 25px;">Expenditure</h5>
                                <p class="card-text merienda-custom-header text-center text-success" style="font-size: 22px;">
                                    <%= request.getAttribute("expense") != null ? "Rs. " + request.getAttribute("expense") : "0.00" %>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <canvas id="financialChart" width="300" height="100" style="margin-top: 20px;"></canvas>
                
                <form action = "dashboard" method="POST" style="text-align: center; margin-top : 10px;">
            		                 
            		   <button type="submit" class="btn btn-success merienda-custom-header">Reload Data</button>               		       
                </form>
            </div>
        </div>
    </div>
    
    
    
     
    
<script>
    const income = <%= request.getAttribute("income") != null ? request.getAttribute("income") : 0 %>;
    const expenditure = <%= request.getAttribute("expense") != null ? request.getAttribute("expense") : 0 %>;
    const balance = <%= request.getAttribute("balance") != null ? request.getAttribute("balance") : 0 %>;

    const ctx = document.getElementById('financialChart').getContext('2d');
    const financialChart = new Chart(ctx, {
        type: 'line', // Line graph type
        data: {
            labels: ['Income', 'Expenditure', 'Balance'],
            datasets: [{
                label: 'Financial Overview',
                data: [income, expenditure, balance],
                fill: false, // No fill below the line
                borderColor: 'green', // Line color
                tension: 0, // No curve, straight lines between points
                backgroundColor: 'rgba(75, 192, 192, 0.2)', // Color for points
                pointBackgroundColor: ['rgba(75, 192, 192, 1)', 'rgba(255, 99, 132, 1)', 'rgba(255, 206, 86, 1)'], // Colors for each point
                borderWidth: 2 // Thickness of the line
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true // Start the Y-axis at 0
                }
            },
            plugins: {
                legend: {
                    display: true // Display the legend
                }
            }
        }
    });
</script>
	
</body>
</html>