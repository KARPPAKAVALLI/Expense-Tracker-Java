package com.expensetracker.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class DashboardDao extends ParentDao {
	public Map<String, Object> getUserDetails(int userId) throws SQLException {
		System.out.println("The user id = " + userId);
		String query = "SELECT user.username, \r\n" + "       COALESCE(SUM(income.Amount), 0) AS total_income, \r\n"
				+ "       COALESCE(SUM(expense.Amount), 0) AS total_expense,\r\n"
				+ "       COALESCE(SUM(income.Amount), 0) - COALESCE(SUM(expense.Amount), 0) AS balance\r\n"
				+ "FROM user\r\n" + "LEFT JOIN income ON user.UserID = income.UserID\r\n"
				+ "LEFT JOIN expense ON user.UserID = expense.UserID\r\n" + "WHERE user.UserID = ?\r\n"
				+ "GROUP BY user.UserID;\r\n";

		Map<String, Object> userDetails = new HashMap<>();

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, userId);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					userDetails.put("username", rs.getString("username"));
					userDetails.put("income", rs.getDouble("total_income"));
					userDetails.put("expense", rs.getDouble("total_expense"));
					userDetails.put("balance", rs.getDouble("balance"));
				}
			}
		}

		return userDetails;
	}
}
