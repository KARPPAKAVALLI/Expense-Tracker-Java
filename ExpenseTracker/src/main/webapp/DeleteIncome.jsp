<%@ page import = "com.expensetracker.dto.IncomeDto, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="images/iconTag.png">
    <title>Delete Income</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/dashboard.css">
</head>
<body>
    <%
        // Prevent back button from caching the page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        
        // Check if 'userid' session attribute is set
        if (session.getAttribute("userid") == null) {
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
                <a href="Dashboard.jsp" class="nav-link merienda-custom-header light-green-shadow">Dashboard</a>
                <a href="Income.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Income</a>
                <a href="DeleteIncome.jsp" class="nav-link merienda-custom-header light-green-shadow bg-success text-white">Delete Income</a>
                <a href="Expense.jsp" class="nav-link merienda-custom-header light-green-shadow">Add Expense</a>
                <a href="DeleteExpense.jsp" class="nav-link merienda-custom-header light-green-shadow">Delete Expense</a>
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
            <h2 class="dashboard-heading merienda-custom-header text-center text-success">Delete Income</h2>

            <!-- Fetch Income Form -->
            <div class="container d-flex justify-content-center align-items-center" style="min-height: 60vh;">
                <div class="col-md-6">
                    <form action="deleteIncome" method="POST">
                        <div class="mb-3">
                            <label for="date" class="form-label merienda-custom-header">Select Date</label>
                            <input type="date" class="form-control merienda-custom-header" id="date" name="date" required>
                        </div>
                        <div class="d-flex justify-content-center">
                            <button type="submit" class="btn btn-success merienda-custom-header">Fetch Income</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Display Income Records -->
            <div class="container" style="max-height: 40vh; overflow-y: auto;"> <!-- Added scrolling container -->
                <%
                    List<IncomeDto> incomes = (List<IncomeDto>) request.getAttribute("incomes");
                    if (incomes != null && !incomes.isEmpty()) {
                %>
                    <h2 class="text-center">Your Incomes</h2>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (IncomeDto income : incomes) {
                            %>
                            <tr>
                                <td><%= income.getDate() %></td>
                                <td><%= income.getAmount() %></td>
                                <td>
                                    <!-- Form to delete the income -->
                                    <form action="deleteIncome" method="post" style="display:inline;">
                                        <input type="hidden" name="incomeId" value="<%= income.getIncomeID() %>">
                                        <input type="hidden" name="date" value="<%= income.getDate() %>"> <!-- Include date -->
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this income?');">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                <%
                    } else if (incomes != null) {
                        out.println("<p>No income records found for the selected date.</p>");
                    }
                %>
            </div>

        </div>
    </div>
</div>
</body>
</html>
