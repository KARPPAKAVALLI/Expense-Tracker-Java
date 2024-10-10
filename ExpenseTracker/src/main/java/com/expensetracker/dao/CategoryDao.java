package com.expensetracker.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoryDao extends ParentDao {
	public int getCategoryId(String category) {
		String query = "SELECT CategoryID FROM CATEGORY WHERE CategoryName = ?";
		PreparedStatement ps;
		int categoryId = -1;
		try {
			ps = connection.prepareStatement(query);
			ps.setString(1, category);
			ResultSet rs = ps.executeQuery();
			rs.next();
			categoryId = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return categoryId;
	}
}
