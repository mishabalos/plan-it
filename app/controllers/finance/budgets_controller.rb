class Finance::BudgetsController < ApplicationController
  include FinanceTripAccessible
  before_action :set_budget, only: [ :edit, :update ]

  def new
    @budget = @trip.build_budget
  end

  def create
    @budget = @trip.build_budget(budget_params)
    if @budget.save
      redirect_to trip_path(@trip), notice: "Budget created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @budget.update(budget_params)
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
