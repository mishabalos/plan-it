class TripCollaboratorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip
  before_action :authorize_owner!

  def index
    @collaborators = @trip.trip_collaborators.includes(:user)
  end

  def new
    @trip_collaborator = @trip.trip_collaborators.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @trip_collaborator = @trip.trip_collaborators.build(user: @user, role: "viewer")
      if @trip_collaborator.save
        redirect_to trip_collaborators_path(@trip), notice: "Collaborator added"
      else
        render :new
      end
    else
      redirect_to new_trip_collaborator_path(@trip), alert: "User not found"
    end
  end

  def update
    @trip_collaborator = @trip.trip_collaborators.find(params[:id])
    if @trip_collaborator.update(role: params[:role])
      redirect_to trip_collaborators_path(@trip), notice: "Role updated"
    else
      redirect_to trip_collaborators_path(@trip), alert: "Update failed"
    end
  end

  def destroy
    @trip_collaborator = @trip.trip_collaborators.find(params[:id])
    @trip_collaborator.destroy
    redirect_to trip_collaborators_path(@trip), notice: "Collaborator removed"
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def authorize_owner!
    unless @trip.owner?(current_user)
      redirect_to trips_path, alert: "Unauthorized"
    end
  end
end
