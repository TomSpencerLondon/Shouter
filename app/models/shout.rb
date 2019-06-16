class Shout < ApplicationRecord
  belongs_to :user
  default_scope { order("created_at DESC") }
  belongs_to :content, polymorphic: true, dependent: :destroy
  validates_associated :content
end
