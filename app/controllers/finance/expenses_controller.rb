class Finance::ExpensesController < ApplicationController
  include FinanceTripAccessible
  before_action :set_budget
  before_action :set_expense, only: [ :show, :edit, :update, :destroy ]

  def index
    @expenses = @budget.expenses.includes(:user, :expense_splits)
  end

  def show
  end

  def new
    @expense = @budget.expenses.build
  end

  def edit
  end

  def create
    @expense = @budget.expenses.build(expense_params)
    @expense.user = current_user

    if @expense.save
      create_splits if params[:split_with].present?
      redirect_to trip_budget_expenses_path(@trip), notice: "Expense added."
    else
      render :new
    end
  end

  def update
    if @expense.update(expense_params)
      @expense.expense_splits.destroy_all
      create_splits if params[:split_with].present?
      redirect_to trip_budget_expenses_path(@trip), notice: "Expense updated."
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to trip_budget_expenses_path(@trip), notice: "Expense deleted."
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :category, :date)
  end

  def set_budget
    @budget = @trip.budget
  end

  def set_expense
    @expense = @budget.expenses.find(params[:id])
  end

  def create_splits
    split_amount = (@expense.amount.to_d / (params[:split_with].count + 1)).round(2)
    params[:split_with].each do |user_id|
      @expense.expense_splits.create(user_id: user_id, amount: split_amount)
    end
  end
end
