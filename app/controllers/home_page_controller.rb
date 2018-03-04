# frozen_string_literal: true

class HomePageController < ApplicationController
  before_action :authenticate_user!

  def show
  end
end
