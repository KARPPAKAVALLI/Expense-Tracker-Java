package com.expensetracker;

import java.io.IOException;
import java.sql.SQLException;

import com.expensetracker.dao.LoginDao;
import com.expensetracker.dao.RegisterDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password"); // plaintext password
		String mobile = request.getParameter("phone");
		String email = request.getParameter("email");

		try {
			RegisterDao registerDao = new RegisterDao();
			LoginDao loginDao = new LoginDao();
			if (registerDao.addUser(username, password, mobile, email)) {
				HttpSession session = request.getSession();
				int userId = loginDao.getUserId(email);
				session.setAttribute("userid", userId);
				session.setAttribute("username", username);

				response.sendRedirect("Dashboard.jsp");
			} else {
				// Handle failure (e.g., user already exists) - show an error message
				request.setAttribute("errorMessage", "Registration failed. User may already exist.");
				request.getRequestDispatcher("Register.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			response.getWriter().print("in servlet");
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error occurred. Please try again.");
			request.getRequestDispatcher("Register.jsp").forward(request, response);
		}

	}
}
