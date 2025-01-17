class ActivityLogsController < ApplicationController
  include TripAccessible

  skip_before_action :authorize_trip_edit!
  before_action :authorize_trip_access!
  
  def index
    @activity_logs = @trip.activity_logs.includes(:user, :target).order(created_at: :desc)
  end
end