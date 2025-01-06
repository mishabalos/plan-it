module TripAccessible
  extend ActiveSupport::Concern

  included do
    before_action :set_trip
    before_action :authorize_trip_access!
    before_action :authorize_trip_edit!, except: [ :index, :show ]
  end

  private

  def set_trip
    @trip = Trip.joins(:trip_collaborators)
                .where("trips.user_id = ? OR trip_collaborators.user_id = ?", current_user.id, current_user.id)
                .find(params[:trip_id])
  end
end
