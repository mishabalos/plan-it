class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name ])
  end

  def authorize_trip_access!
    unless @trip.can_view?(current_user)
      redirect_to trips_path, alert: "Unauthorized"
    end
  end

  def authorize_trip_edit!
    unless @trip.can_edit?(current_user)
      redirect_to trips_path, alert: "Unauthorized"
    end
  end
end
