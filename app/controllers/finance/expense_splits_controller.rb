class Finance::ExpenseSplitsController < ApplicationController
  include FinanceTripAccessible
  before_action :set_expense

  def create
    @split = @expense.expense_splits.build(split_params)
    if @split.save
      redirect_to trip_budget_expense_path(@trip, @expense), notice: "Split added."
    else
      redirect_to trip_budget_expense_path(@trip, @expense), alert: "Error adding split."
    end
  end

  private

  def split_params
    params.require(:expense_split).permit(:user_id, :amount)
  end

  def set_expense
    @expense = @trip.budget.expenses.find(params[:expense_id])
  end
end
