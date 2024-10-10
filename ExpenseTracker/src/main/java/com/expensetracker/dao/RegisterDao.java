package com.expensetracker.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterDao extends ParentDao implements Password {

	public boolean addUser(String username, String password, String phone, String email) throws SQLException {
		if (isEmailExist(email) || isPhoneExist(phone)) {
			return false;
		}

		String hashedPassword = hashPassword(password); // Hash the password
		String query = "INSERT INTO USER(Username, Phone, Email_address, Password) VALUES(?,?,?,?)";

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, username);
			ps.setString(2, phone);
			ps.setString(3, email);
			ps.setString(4, hashedPassword);
			ps.executeUpdate();
		}
		return true;
	}

	private boolean isPhoneExist(String phone) throws SQLException {
		String query = "SELECT COUNT(*) FROM USER WHERE Phone = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, phone);
			ResultSet rs = ps.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				return true;
			}
		}
		return false;
	}

	private boolean isEmailExist(String email) throws SQLException {
		String query = "SELECT COUNT(*) FROM USER WHERE Email_address = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				return true;
			}
		}
		return false;
	}

}
