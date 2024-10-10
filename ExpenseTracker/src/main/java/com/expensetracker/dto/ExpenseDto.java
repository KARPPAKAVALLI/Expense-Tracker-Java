package com.expensetracker.dto;

import java.sql.Date;

public class ExpenseDto {
	private int expenseId;
	private int userId; // UserID associated with the expense
	private int categoryId; // CategoryID associated with the expense

	public String getCategory() {
		return category;
	}

	private double amount; // Amount of the expense
	private Date date; // Date of the expense
	private Date createdAt; // Timestamp for when the record was created
	private Date updatedAt; // Timestamp for when the record was last updated
	private String category;

	// Constructor
	public ExpenseDto(int expenseId, int userId, int categoryId, double amount, Date date, Date createdAt,
			Date updatedAt) {
		this.expenseId = expenseId;
		this.userId = userId;
		this.categoryId = categoryId;
		this.amount = amount;
		this.date = date;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public ExpenseDto(int expenseId, double amount, Date date, String category) {
		super();
		this.amount = amount;
		this.date = date;
		this.category = category;
		this.expenseId = expenseId;
	}

	// Getters and Setters
	public int getExpenseId() {
		return expenseId;
	}

	public void setExpenseId(int expenseId) {
		this.expenseId = expenseId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
}
