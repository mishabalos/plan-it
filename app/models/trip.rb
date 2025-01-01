class Trip < ApplicationRecord
  belongs_to :user
  has_many :destinations
  has_many :itineraries

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  private
  def end_date_after_start_date
    if start_date && end_date && end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
