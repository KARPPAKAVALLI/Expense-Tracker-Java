<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="com.expensetracker.dto.ExpenseDto"%>
<%@ page import="com.expensetracker.dao.ExpenseDao"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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

    <!-- Chart.js for pie chart -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        #expenseChart {
            max-width: 300px; 
            max-height: 300px; 
        }
    </style>
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
                <div class="nav-links" style="margin-top: 10px;">
                    <a href="Dashboard.jsp" class="nav-link merienda-custom-header light-green-shadow">Dashboard</a>
                    <a href="Income.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Income</a>
                    <a href="DeleteIncome.jsp" class="nav-link merienda-custom-header light-green-shadow">Delete Income</a>
                    <a href="Expense.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Expense</a>
                    <a href="DeleteExpense.jsp" class="nav-link merienda-custom-header light-green-shadow">Delete Expense</a>
                    <a href="ExpenseReport.jsp" class="nav-link merienda-custom-header light-green-shadow bg-success text-white">View Report</a>
                </div>
                <div class="logout-container">
				    <a href="LogoutServlet" class="nav-link merienda-custom-header logout" style="display: flex;">
				        Logout 
				        <img src="images/logout.png" alt="Logout" style="width: 20px; height: 20px; margin-left: 5px;">
				    </a>
				</div>
            </div>
            <div class="col-lg-8 col-md-8 col-sm-12 right-grid light-green-shadow">
                <%
                    // Show the error message if it exists
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                        out.println("<p style='color:red;'>" + errorMessage + "</p>");
                    }

                    // Prevent page caching
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                    // Check if 'userid' session attribute is set
                    if(session.getAttribute("userid") == null){
                        // Redirect to login page if 'userid' is not found in session
                        response.sendRedirect("Login.jsp");
                    }
                %>

                <h1 class="text-center">Expense Report</h1>
                <form action="generateReport" method="post" class="text-center my-4">
                    <label for="fromDate">From Date:</label>
                    <input type="date" id="fromDate" name="fromDate" required>
                    <label for="toDate">To Date:</label>
                    <input type="date" id="toDate" name="toDate" required>
                    <button type="submit" class="btn btn-success">Generate Report</button>
                </form>

                <div class="row my-4">
                    <div class="col-md-6">
                        <h2>Your Expenses</h2>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Category</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<ExpenseDto> expenses = (List<ExpenseDto>) request.getAttribute("expenses");
                                    if (expenses != null && !expenses.isEmpty()) {
                                        for (ExpenseDto expense : expenses) {
                                %>
                                    <tr>
                                        <td><%= expense.getDate() %></td>
                                        <td><%= expense.getCategory() %></td>
                                        <td><%= expense.getAmount() %></td>
                                    </tr>
                                <%
                                        }
                                    } else {
                                        out.println("<tr><td colspan='3'>No expenses found for the selected date range.</td></tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <div class="col-md-6">
                        <!-- Pie Chart Container -->
                        <div class="my-4 d-flex justify-content-center align-items-center" style="height: 100%;">
                            <canvas id="expenseChart" width="300" height="300"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Data for the pie chart
        const expenseData = {
            labels: [<% 
                if (expenses != null && !expenses.isEmpty()) {
                    for (ExpenseDto expense : expenses) {
                        out.print("'" + expense.getCategory() + "',");
                    }
                } 
            %>],
            datasets: [{
                label: 'Expenses',
                data: [<% 
                    if (expenses != null && !expenses.isEmpty()) {
                        for (ExpenseDto expense : expenses) {
                            out.print(expense.getAmount() + ",");
                        }
                    } 
                %>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        };

        // Config for the pie chart
        const config = {
            type: 'pie',
            data: expenseData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Expense Distribution by Category'
                    }
                }
            },
        };

        const expenseChart = new Chart(
            document.getElementById('expenseChart'),
            config
        );
    </script>
</body>
</html>