class Shout < ApplicationRecord
  searchkick word_start: [:content]

  belongs_to :user
  default_scope { order("created_at DESC") }
  belongs_to :content, polymorphic: true, dependent: :destroy
  validates_associated :content

  def self.text_shouts
    where(content_type: 'TextShout')
  end

  def self.shouts
    Shout.all.map(&:content)
  end

  def search_data
    {
      content: content.index
    }
  end
end
