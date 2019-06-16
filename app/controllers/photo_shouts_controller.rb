class PhotoShoutsController < ApplicationController
  def create
    if shout.save
      redirect_to dashboard_path
    else
      flash.alert = "Could not shout."
      redirect_to dashboard_path
    end
  end

  private

  def shout
    ShoutBuilderService.new(PhotoShout,
                            photo_shout_parameters,
                            current_user).shout
  end

  def photo_shout_parameters
    return false if params[:photo_shout].blank?
    params.require(:photo_shout).permit(:image)
  end
end
