class HomesController < ApplicationController
  before_action :checked_logged_in_user

  def show
  end

  private

  def checked_logged_in_user
    if signed_in?
      redirect_to dashboard_path
    end
  end
end