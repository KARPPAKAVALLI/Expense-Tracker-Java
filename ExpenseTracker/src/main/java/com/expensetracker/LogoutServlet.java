package com.expensetracker;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false); // Fetch session, don't create a new one

		if (session != null) {
			session.removeAttribute("userId"); // Remove userId from session
			session.removeAttribute("username"); // Remove username from session
			session.invalidate(); // Invalidate session to remove all attributes
		}

		response.sendRedirect("Home.jsp"); // Redirect to home or login page after logout
	}

}
