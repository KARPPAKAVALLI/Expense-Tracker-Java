package com.expensetracker;

import java.io.IOException;

import com.expensetracker.dao.LoginDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		try {
			LoginDao loginDao = new LoginDao();
			if (loginDao.verifyUser(password, email)) {
				// set userid in session
				HttpSession session = request.getSession();
				int userId = loginDao.getUserId(email);
				session.setAttribute("userid", userId);
				String username = loginDao.getUserName(userId);
				session.setAttribute("username", username);
				response.sendRedirect("Dashboard.jsp");
			} else {
				// User doesn't exist/ wrong credentials
				request.setAttribute("errorMessage", "Login failed. Inavalid credentials.");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getStackTrace());
		}
	}

}
