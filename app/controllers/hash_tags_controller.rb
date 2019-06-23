class HashTagsController < ApplicationController
  def show
    @search = Search.new(term: hashtag)
  end

  def hashtag
    "##{params[:id]}"
  end
end
