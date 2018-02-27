class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, :notice => 'You should be logged in order to see this page'
    end
  end
end
