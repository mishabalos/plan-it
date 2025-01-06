module FinanceTripAccessible
  extend ActiveSupport::Concern

  included do
    include TripAccessible
    skip_before_action :authorize_trip_edit!
  end
end
