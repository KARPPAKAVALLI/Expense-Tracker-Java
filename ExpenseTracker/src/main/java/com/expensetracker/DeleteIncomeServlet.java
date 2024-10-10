package com.expensetracker;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.expensetracker.dao.IncomeDao;
import com.expensetracker.dto.IncomeDto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteIncome")
public class DeleteIncomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		int userid = (int) session.getAttribute("userid");

		// Check if the request is for deleting an income
		String incomeIdParam = request.getParameter("incomeId");
		if (incomeIdParam != null) {
			int incomeId = Integer.parseInt(incomeIdParam);
			try {
				IncomeDao incomeDao = new IncomeDao();
				incomeDao.deleteIncome(incomeId); // Delete the income
				response.sendRedirect("DeleteIncome.jsp"); // Redirect after deletion
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("DeleteIncome.jsp");
			}
		} else {
			// Handle fetching incomes for a specific date
			String dateString = request.getParameter("date");
			Date date = Date.valueOf(dateString);

			try {
				IncomeDao incomeDao = new IncomeDao();
				List<IncomeDto> incomes = incomeDao.getUserIncome(userid, date);
				request.setAttribute("incomes", incomes);
				request.getRequestDispatcher("DeleteIncome.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("DeleteIncome.jsp");
			}
		}
	}

}
