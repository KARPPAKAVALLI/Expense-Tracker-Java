package com.expensetracker.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.expensetracker.dto.IncomeDto;

public class IncomeDao extends ParentDao {

	public void addIncome(int userId, Double amount, Date sqlDate) throws SQLException {
		String query = "INSERT INTO INCOME(UserID, Amount, Date) VALUES(?, ?, ?);";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setInt(1, userId);
		ps.setDouble(2, amount);
		ps.setDate(3, sqlDate);
		ps.executeUpdate();
	}

	// Retrieve incomes for a specific user and date range
	public List<IncomeDto> getUserIncome(int userId, Date startDate) throws SQLException {
		List<IncomeDto> incomes = new ArrayList<IncomeDto>();
		String query = "SELECT i.IncomeID, i.UserID, i.Amount, i.Date FROM INCOME i "
				+ "WHERE i.UserID = ? AND i.DATE = ?;";

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, userId);
			ps.setDate(2, startDate);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				IncomeDto income = new IncomeDto(rs.getInt("IncomeID"), rs.getDouble("Amount"), rs.getDate("Date"));
				incomes.add(income);
			}
		}
		return incomes;
	}

	// Delete a specific income by ID
	public void deleteIncome(int incomeId) throws SQLException {
		String query = "DELETE FROM INCOME WHERE IncomeID = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, incomeId);
			ps.executeUpdate();
		}
	}

}
