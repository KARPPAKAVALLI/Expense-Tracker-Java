package com.expensetracker.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.expensetracker.dto.ExpenseDto;

public class ReportDao extends ParentDao {

	public List<ExpenseDto> getUserExpense(int userId, Date startDate, Date endDate) throws SQLException {
		List<ExpenseDto> expenses = new ArrayList<ExpenseDto>();
		ResultSet rs = getUserExpenseFromTable(userId, startDate, endDate);
		while (rs.next()) {
			ExpenseDto expense = new ExpenseDto(rs.getInt(1), rs.getDouble(3), rs.getDate(4), rs.getString(5));
			expenses.add(expense);
		}
		return expenses;
	}

	private ResultSet getUserExpenseFromTable(int userId, Date startDate, Date endDate) {
		String query = "SELECT \r\n" + "    e.ExpenseID,\r\n" + "    e.UserID,\r\n" + "    e.Amount,\r\n"
				+ "    e.Date,\r\n" + "    c.CategoryName\r\n" + "FROM \r\n" + "    EXPENSE e\r\n" + "LEFT JOIN \r\n"
				+ "    CATEGORY c ON e.CategoryID = c.CategoryID\r\n" + "WHERE \r\n"
				+ "    e.UserID = ? AND e.DATE BETWEEN ? AND ? ;";
		ResultSet rs = null;
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setInt(1, userId);
			ps.setDate(2, startDate);
			ps.setDate(3, endDate);
			rs = ps.executeQuery();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}

}
