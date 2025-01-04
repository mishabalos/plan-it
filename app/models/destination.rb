class Destination < ApplicationRecord
  belongs_to :trip
  validates :name, presence: true
  validates :country, presence: true
  validates :city, presence: true
end
