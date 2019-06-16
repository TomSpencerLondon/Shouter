class User < ActiveRecord::Base
  include Following

  has_many :shouts

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :password_digest, presence: true
end
