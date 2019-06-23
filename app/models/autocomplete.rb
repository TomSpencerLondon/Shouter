class Autocomplete
  include ActiveModel::Model
  attr_reader :term
  def initialize(options = {})
    @term = options.fetch(:term)
  end

  def matches
    result = []
    shouts.each do |shout|
      result |= [shout.body] if text_shout?(shout)
      result |= [shout.image_file_name] if photo_shout?(shout)
    end
    result
  end

  private

  def shouts
    search.map(&:content)
  end

  def search
    Shout.search(term, includes: [:content], match: :word_start).results
  end

  def photo_shout?(shout)
    shout.instance_of?(PhotoShout)
  end

  def text_shout?(shout)
    shout.instance_of?(TextShout)
  end
end