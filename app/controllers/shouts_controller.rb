class ShoutsController < ApplicationController
  def show
    @shout = Shout.find(params[:id])
  end

  def destroy
    shout = Shout.find(params[:id])
    shout.destroy
    redirect_to dashboard_path
  end
end