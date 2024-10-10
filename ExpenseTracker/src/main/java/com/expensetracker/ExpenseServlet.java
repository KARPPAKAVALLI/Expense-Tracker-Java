package com.expensetracker;

import java.io.IOException;
import java.sql.Date;

import com.expensetracker.dao.CategoryDao;
import com.expensetracker.dao.ExpenseDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class ExpenseServlet
 */
@WebServlet("/addExpense")
public class ExpenseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userid = (int) session.getAttribute("userid");
		Double amount = Double.valueOf(request.getParameter("amount"));
		int categoryId = new CategoryDao().getCategoryId(request.getParameter("categoryName"));
		String dateString = request.getParameter("date"); // e.g., "2024-09-30"
		Date sqlDate = Date.valueOf(dateString);
		try {
			ExpenseDao ed = new ExpenseDao();
			ed.addExpense(userid, amount, categoryId, sqlDate);
			// Set success message
			request.setAttribute("message", "Expense successfully added.");
			// Forward to Income.jsp
			request.getRequestDispatcher("Expense.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getStackTrace());
		}
	}

}
