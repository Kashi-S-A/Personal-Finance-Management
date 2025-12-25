package com.ksa.pfm.dto;

public class CategorySummaryDTO {
	private String category;
    public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public double getBudget() {
		return budget;
	}

	public void setBudget(double budget) {
		this.budget = budget;
	}

	public double getSpent() {
		return spent;
	}

	public void setSpent(double spent) {
		this.spent = spent;
	}

	private double budget;
    private double spent;

    public CategorySummaryDTO(String category, double budget, double spent) {
        this.category = category;
        this.budget = budget;
        this.spent = spent;
    }
}
