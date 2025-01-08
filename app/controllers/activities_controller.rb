class ActivitiesController < ApplicationController
  include TripAccessible
  before_action :authenticate_user!
  before_action :set_itinerary
  before_action :set_activity, only: [ :show, :edit, :update, :destroy ]

  def index
    @activities = @itinerary.activities
  end

  def show
  end

  def new
    @activity = @itinerary.activities.build
  end

  def create
    @activity = @itinerary.activities.build(activity_params)
    if @activity.save
      redirect_to trip_itinerary_activity_path(@trip, @itinerary, @activity), notice: "Activity created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to trip_itinerary_activity_path(@trip, @itinerary, @activity), notice: "Activity updated."
    else
      render :edit
    end
  end

  def destroy
    @activity.destroy
    redirect_to trip_itinerary_activities_path(@trip, @itinerary), notice: "Activity deleted."
  end

  private

  def set_itinerary
    @itinerary = @trip.itineraries.find(params[:itinerary_id])
  end

  def set_activity
    @activity = @itinerary.activities.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :description, :start_time, :end_time,
                                   :latitude, :longitude, :location_name, :formatted_address)
  end
end
