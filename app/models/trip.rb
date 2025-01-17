class Trip < ApplicationRecord
  belongs_to :user
  has_many :destinations, dependent: :destroy 
  has_many :itineraries, dependent: :destroy
  has_many :trip_collaborators, dependent: :destroy
  has_many :collaborators, through: :trip_collaborators, source: :user
  has_many :activity_logs, dependent: :destroy
  has_one :budget, class_name: "Finance::Budget", dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :latitude, numericality: true, allow_nil: true
  validates :longitude, numericality: true, allow_nil: true

  def owner?(user)
    self.user == user
  end

  def collaborator?(user)
    trip_collaborators.exists?(user: user)
  end

  def can_view?(user)
    owner?(user) || collaborator?(user)
  end

  def can_edit?(user)
    owner?(user) || trip_collaborators.exists?(user: user, role: "editor")
  end

  def log_activity(user, action, target = nil, details = {})
    activity_logs.create!(
      user: user,
      action: action,
      target: target,
      details: details
    )
  end

  private
  def end_date_after_start_date
    if start_date && end_date && end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
