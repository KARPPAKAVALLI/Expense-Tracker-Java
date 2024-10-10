package com.expensetracker;

import java.io.IOException;
import java.sql.Date;

import com.expensetracker.dao.IncomeDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class IncomeServlet
 */
@WebServlet("/addIncome")
public class IncomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userid = (int) session.getAttribute("userid");
		Double amount = Double.valueOf(request.getParameter("amount"));
		String dateString = request.getParameter("date");
		Date sqlDate = Date.valueOf(dateString);
		try {
			new IncomeDao().addIncome(userid, amount, sqlDate);
			// Set success message
			request.setAttribute("message", "Income successfully added.");
			// Forward to Income.jsp
			request.getRequestDispatcher("Income.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

}
