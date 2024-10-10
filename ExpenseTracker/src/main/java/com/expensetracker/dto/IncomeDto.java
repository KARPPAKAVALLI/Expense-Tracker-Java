package com.expensetracker.dto;

import java.sql.Date;

public class IncomeDto {
	private int incomeID;
	private double amount;
	private Date date;

	public IncomeDto(int incomeID, double amount, Date date) {
		this.incomeID = incomeID;
		this.amount = amount;
		this.date = date;
	}

	// Getters and Setters
	public int getIncomeID() {
		return incomeID;
	}

	public void setIncomeID(int incomeID) {
		this.incomeID = incomeID;
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

}
