class Event < ApplicationRecord
  belongs_to :user
  has_many :users, through: :joins
  has_many :joins, dependent: :destroy
  has_many :comments
end
