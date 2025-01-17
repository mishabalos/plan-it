class DestinationsController < ApplicationController
  include TripAccessible
  before_action :authenticate_user!
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
      @trip.log_activity(current_user, 'added_destination', @destination, {
        destination_name: @destination.name,
        city: @destination.city,
        country: @destination.country
      })
      redirect_to trip_destination_path(@trip, @destination), notice: "Destination created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @destination.update(destination_params)
      @trip.log_activity(current_user, 'updated_destination', @destination, {
        changed_fields: @destination.previous_changes.keys
      })
      redirect_to trip_destination_path(@trip, @destination), notice: "Destination updated."
    else
      render :edit
    end
  end

  def destroy
    @trip.log_activity(current_user, 'removed_destination', @destination, {
      destination_name: @destination.name
    })
    @destination.destroy
    redirect_to trip_destinations_path(@trip), notice: "Destination deleted."
  end

  private

  def set_destination
    @destination = @trip.destinations.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(:name, :country, :city)
  end
end
