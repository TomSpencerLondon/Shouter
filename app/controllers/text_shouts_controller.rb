class TextShoutsController < ApplicationController
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
    ShoutBuilderService.new(TextShout,
                            text_shout_parameters,
                            current_user).shout
  end

  def text_shout_parameters
    params.require(:text_shout).permit(:body)
  end
end
