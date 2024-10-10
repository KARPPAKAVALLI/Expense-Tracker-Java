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

@WebServlet("/generateIncomeReport")
public class IncomeReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userid = (int) session.getAttribute("userid");
		String fromDateString = request.getParameter("fromDate");
		String toDateString = request.getParameter("toDate");
		Date fromDate = Date.valueOf(fromDateString);
		Date toDate = Date.valueOf(toDateString);

		try {
			IncomeDao incomeDao = new IncomeDao();
			List<IncomeDto> incomes = incomeDao.getUserIncome(userid, fromDate, toDate);
			request.setAttribute("incomes", incomes);
			request.getRequestDispatcher("IncomeReport.jsp").forward(request, response); // Ensure this line forwards to
																							// the correct page
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}
}
