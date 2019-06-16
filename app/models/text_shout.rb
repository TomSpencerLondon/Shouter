class TextShout < ApplicationRecord
  validates :body, presence: :true
end
