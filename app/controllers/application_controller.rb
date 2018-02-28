# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:username, :email, :password,
        :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:username, :email, :password,
        :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar)
    end
  end
end
