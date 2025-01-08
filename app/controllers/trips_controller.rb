class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_view!, only: [ :show ]
  before_action :authorize_edit!, only: [ :edit, :update, :destroy ]

  def index
    @trips = current_user.trips + Trip.joins(:trip_collaborators)
                                    .where(trip_collaborators: { user_id: current_user.id })
  end

  def show
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.build(trip_params)
    if @trip.save
      redirect_to @trip, notice: "Trip created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip, notice: "Trip updated."
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path, notice: "Trip deleted."
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def authorize_view!
    unless @trip.can_view?(current_user)
      redirect_to trips_path, alert: "Unauthorized"
    end
  end

  def authorize_edit!
    unless @trip.can_edit?(current_user)
      redirect_to trips_path, alert: "Unauthorized"
    end
  end

  def trip_params
    params.require(:trip).permit(:title, :description, :start_date, :end_date,
                               :latitude, :longitude, :location_name)
  end
end
