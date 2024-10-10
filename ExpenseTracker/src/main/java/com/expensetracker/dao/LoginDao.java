package com.expensetracker.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao extends ParentDao implements Password {

	public boolean verifyUser(String password, String email) throws SQLException {
		password = hashPassword(password);
		String query = "SELECT * FROM USER WHERE Email_Address = ? AND Password = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, email);
			ps.setString(2, password);
			try (ResultSet rs = ps.executeQuery()) {
				// Check if any row is returned
				return rs.next(); // Returns true if there's at least one row
			}
		}
	}

	public int getUserId(String email) throws SQLException {
		PreparedStatement ps = connection.prepareStatement("SELECT USERID FROM USER WHERE Email_Address = ?");
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		rs.next();
		return rs.getInt(1);
	}

	public String getUserName(int userId) throws SQLException {
		PreparedStatement ps = connection.prepareStatement("SELECT Username FROM USER WHERE Userid = ?");
		ps.setInt(1, userId);
		ResultSet rs = ps.executeQuery();
		rs.next();
		return rs.getString(1);
	}
}
