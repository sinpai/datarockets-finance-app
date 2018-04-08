class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def form_errors
    @form.errors.messages.map { |key, _| key.to_s.titleize }.join(', ') +
      ' ' + @form.errors.messages.map { |_, value| value }.flatten.join(' and ')
  end

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

  def authenticate_user!(options = {})
    if user_signed_in?
      super(options)
    else
      redirect_to new_user_session_path, notice: t('.log_in_warning')
    end
  end
end
