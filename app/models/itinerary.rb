class Itinerary < ApplicationRecord
  belongs_to :trip
  has_many :activities
  validates :date, presence: true
end
