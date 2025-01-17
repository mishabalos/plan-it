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

    respond_to do |format|
      if @activity.save
        @trip.log_activity(current_user, 'added_activity', @activity, {
       name: @activity.name,
       itinerary_date: @itinerary.date,
       start_time: @activity.start_time.strftime("%I:%M %p"),
       end_time: @activity.end_time.strftime("%I:%M %p")
     })
        format.turbo_stream {
          redirect_to trip_itinerary_activity_path(@trip, @itinerary, @activity),
          notice: "Activity created."
        }
        format.html {
          redirect_to trip_itinerary_activity_path(@trip, @itinerary, @activity),
          notice: "Activity created."
        }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      @trip.log_activity(current_user, 'updated_activity', @activity, {
        name: @activity.name,
        changed_fields: @activity.previous_changes.keys,
        itinerary_date: @itinerary.date
      })
      redirect_to trip_itinerary_activity_path(@trip, @itinerary, @activity), notice: "Activity updated."
    else
      render :edit
    end
  end

  def destroy
    @trip.log_activity(current_user, 'removed_activity', @activity, {
      name: @activity.name,
      itinerary_date: @itinerary.date
    })
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
