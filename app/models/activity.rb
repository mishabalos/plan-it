class Activity < ApplicationRecord
  belongs_to :itinerary
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time

  private
  def end_time_after_start_time
    if start_time && end_time && end_time < start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
