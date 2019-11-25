class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?



  # def after_sign_in_path_for(resource)
  #   current_user_path
  # end
  #
  # def after_sign_out_path_for(resource_or_scope)
  #   request.referrer
  # end

  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
  #   devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name, :password, :remember_me) }
  #   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :name, :email, :password, :password_confirmation, :current_password) }
  # end


end
