package com.expensetracker.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ExpenseDao extends ParentDao {
	public void addExpense(int userId, Double amount, int categoryId, Date sqlDate) throws SQLException {
		String query = "INSERT INTO EXPENSE(UserId, Amount, CategoryId, Date) VALUES(?,?,?,?)";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setInt(1, userId);
		ps.setDouble(2, amount);
		ps.setInt(3, categoryId);
		ps.setDate(4, sqlDate);
		ps.executeUpdate();
	}

	public void deleteExpense(int expenseId) throws SQLException {
		String query = "DELETE FROM EXPENSE WHERE ExpenseID = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, expenseId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e; // Propagate the exception if needed
		}
	}
}
