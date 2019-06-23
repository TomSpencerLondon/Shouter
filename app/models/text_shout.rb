class TextShout < ApplicationRecord
  validates :body, presence: :true

  def index
    self.body
  end
end
