<%@ page import = "com.expensetracker.dto.IncomeDto, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Income Report</title>
</head>
<body>
	<%
        // Show the error message if it exists
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            out.println("<p style='color:red;'>" + errorMessage + "</p>");
        }
    %>
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
    <h1>Income Report</h1>
    <form action="generateIncomeReport" method="post" onsubmit="return validateDateRange();">
        <label for="fromDate">From Date:</label>
        <input type="date" id="fromDate" name="fromDate" required>

        <label for="toDate">To Date:</label>
        <input type="date" id="toDate" name="toDate" required>

        <button type="submit">Generate Report</button>
    </form>

    <%
        List<IncomeDto> incomes = (List<IncomeDto>) request.getAttribute("incomes");
        if (incomes != null && !incomes.isEmpty()) {
    %>
        <h2>Your Incomes</h2>
        <table>
            <tr>
                <th>Date</th>
                <th>Amount</th>
                <th>Action</th> <!-- New column for actions -->
            </tr>
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
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this income?');">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        } else {
            out.println("<p>No income records found for the selected date range.</p>");
        }
    %>
    <script>
		function validateDateRange() {
		    var fromDate = document.getElementById("fromDate").value;
		    var toDate = document.getElementById("toDate").value;
		
		    if (new Date(fromDate) > new Date(toDate)) {
		        alert("From date cannot be after To date.");
		        return false;
		    }
		    return true;
		}
	</script>
    
</body>
</html>
