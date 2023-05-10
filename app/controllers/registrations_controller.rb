class RegistrationsController < Devise::RegistrationsController
  def new
    super
  rescue ActionController::RoutingError
    redirect_to new_user_registration_path
  end
end