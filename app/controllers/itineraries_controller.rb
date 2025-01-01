class ItinerariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip
  before_action :set_itinerary, only: [ :show, :edit, :update, :destroy ]

  def index
    @itineraries = @trip.itineraries
  end

  def show
    @activities = @itinerary.activities
  end

  def new
    @itinerary = @trip.itineraries.build
  end

  def create
    @itinerary = @trip.itineraries.build(itinerary_params)
    if @itinerary.save
      redirect_to trip_itinerary_path(@trip, @itinerary), notice: "Itinerary created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @itinerary.update(itinerary_params)
      redirect_to trip_itinerary_path(@trip, @itinerary), notice: "Itinerary updated."
    else
      render :edit
    end
  end

  def destroy
    @itinerary.destroy
    redirect_to trip_itineraries_path(@trip), notice: "Itinerary deleted."
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  end

  def set_itinerary
    @itinerary = @trip.itineraries.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:date)
  end
end
