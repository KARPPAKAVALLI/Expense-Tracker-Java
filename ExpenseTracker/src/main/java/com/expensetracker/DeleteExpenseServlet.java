package com.expensetracker;

import java.io.IOException;

import com.expensetracker.dao.ExpenseDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteExpenseServlet
 */
@WebServlet("/deleteExpense")
public class DeleteExpenseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String expenseIdParam = request.getParameter("expenseId");
		if (expenseIdParam == null || expenseIdParam.isEmpty()) {
			// Handle the error appropriately, e.g., set an error message
			response.sendRedirect("DeleteExpense.jsp?error=Expense ID is missing.");
			return;
		}

		int expenseId = Integer.parseInt(expenseIdParam);
		try {
			ExpenseDao expenseDao = new ExpenseDao();
			expenseDao.deleteExpense(expenseId);
			response.sendRedirect("DeleteExpense.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
