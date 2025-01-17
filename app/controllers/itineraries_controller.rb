class ItinerariesController < ApplicationController
  include TripAccessible
  before_action :authenticate_user!
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
      @trip.log_activity(current_user, 'added_itinerary', @itinerary, {
       date: @itinerary.date,
       day_number: (@itinerary.date - @trip.start_date).to_i + 1
     })
      redirect_to trip_itinerary_path(@trip, @itinerary), notice: "Itinerary created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @itinerary.update(itinerary_params)
      @trip.log_activity(current_user, 'updated_itinerary', @itinerary, {
       changed_fields: @itinerary.previous_changes.keys,
       old_date: @itinerary.date_was,
       new_date: @itinerary.date
     })
      redirect_to trip_itinerary_path(@trip, @itinerary), notice: "Itinerary updated."
    else
      render :edit
    end
  end

  def destroy
    @trip.log_activity(current_user, 'removed_itinerary', @itinerary, {
     date: @itinerary.date,
     activities_count: @itinerary.activities.count
   })
    @itinerary.destroy
    redirect_to trip_itineraries_path(@trip), notice: "Itinerary deleted."
  end

  private

  def set_itinerary
    @itinerary = @trip.itineraries.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:date)
  end
end
