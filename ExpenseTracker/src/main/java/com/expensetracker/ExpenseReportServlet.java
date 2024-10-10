package com.expensetracker;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.expensetracker.dao.ReportDao;
import com.expensetracker.dto.ExpenseDto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class ExpenseReportServlet
 */
@WebServlet("/generateReport")
public class ExpenseReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userid = (int) session.getAttribute("userid");
		String fromDateString = request.getParameter("fromDate");
		String toDateString = request.getParameter("toDate");
		Date fromDate = Date.valueOf(fromDateString);
		Date toDate = Date.valueOf(toDateString);

		// Validate that the start date is less than or equal to the end date
		if (fromDate.after(toDate)) {
			// If validation fails, set an error message and redirect back to the report
			// form
			request.setAttribute("errorMessage", "The start date cannot be after the end date.");
			request.getRequestDispatcher("ExpenseReport.jsp").forward(request, response);
			return; // Stop further execution
		}

		try {
			ReportDao reportDao = new ReportDao();
			List<ExpenseDto> expenses = reportDao.getUserExpense(userid, fromDate, toDate);
			request.setAttribute("expenses", expenses);
			request.getRequestDispatcher("ExpenseReport.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
