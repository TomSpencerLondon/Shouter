class Search
  include ActiveModel::Model
  attr_reader :term
  def initialize(options = {})
    @term = options.fetch(:term)
  end

  def shouts
    Shout.search(search_term, includes: [:content], match: :phrase).results
  end

  private

  def search_term
    return "*" unless term.present?

    term
  end
end