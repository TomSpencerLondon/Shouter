class SearchesController < ApplicationController
  def show
    @search = Search.new(params[:search])
  end

  def autocomplete
    render json: Autocomplete.new(params).matches
  end
end
