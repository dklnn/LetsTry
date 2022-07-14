class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # trying to start with redirectind user to relevant error page's when exception called
  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false
  end

  protected

  # added name and avatar fields into devise permitted parameters to link sign up view with model 
  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation remember_me avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
