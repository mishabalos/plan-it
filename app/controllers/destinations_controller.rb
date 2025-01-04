class DestinationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip
  before_action :set_destination, only: [ :show, :edit, :update, :destroy ]

  def index
    @destinations = @trip.destinations
  end

  def show
  end

  def new
    @destination = @trip.destinations.build
  end

  def create
    @destination = @trip.destinations.build(destination_params)
    if @destination.save
      redirect_to trip_destination_path(@trip, @destination), notice: "Destination created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @destination.update(destination_params)
      redirect_to trip_destination_path(@trip, @destination), notice: "Destination updated."
    else
      render :edit
    end
  end

  def destroy
    @destination.destroy
    redirect_to trip_destinations_path(@trip), notice: "Destination deleted."
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  end

  def set_destination
    @destination = @trip.destinations.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(:name, :country, :city)
  end
end
