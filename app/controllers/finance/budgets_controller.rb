class Finance::BudgetsController < ApplicationController
  include FinanceTripAccessible
  before_action :set_budget, only: [ :edit, :update ]

  def new
    @budget = @trip.build_budget
  end

  def create
    @budget = @trip.build_budget(budget_params)
    if @budget.save
      @trip.log_activity(current_user, 'set_budget', @budget, {
        amount: @budget.amount
      })
      redirect_to trip_path(@trip), notice: "Budget created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @budget.update(budget_params)
      @trip.log_activity(current_user, 'updated_budget', @budget, {
         old_amount: @budget.amount_was,
         new_amount: @budget.amount
       })
      redirect_to trip_path(@trip), notice: "Budget updated."
    else
      render :edit
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:amount)
  end

  def set_budget
    @budget = @trip.budget
  end
end
