class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!,except: [:top, :about]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:name, :introduction, :profile_image_id])
  end

  def after_sign_in_path_for(resource)
    if current_user
      flash[:success] = "successfully"
      user_path(@user)
    else
      flash[:success] = "successfully"
      root_path(@user)
    end

  end

end
