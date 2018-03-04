class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, notice: t('.log_in_warning')
    end
  end
end
