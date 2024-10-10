package com.expensetracker;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import com.expensetracker.dao.DashboardDao;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class DashboardServlet
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userid = (int) session.getAttribute("userid");
		DashboardDao dashboardDao = new DashboardDao();
		Map<String, Object> userDetails;
		try {
			userDetails = dashboardDao.getUserDetails(userid);
			request.setAttribute("username", userDetails.get("username"));
			request.setAttribute("income", userDetails.get("income"));
			request.setAttribute("expense", userDetails.get("expense"));
			request.setAttribute("balance", userDetails.get("balance"));
		} catch (SQLException e) {
			response.sendRedirect("login.jsp");
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("Dashboard.jsp");
		dispatcher.forward(request, response);
	}

}
