class Trip < ApplicationRecord
  belongs_to :user
  has_many :destinations
  has_many :itineraries
  has_many :trip_collaborators, dependent: :destroy
  has_many :collaborators, through: :trip_collaborators, source: :user
  has_one :budget, class_name: "Finance::Budget"

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

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

  private
  def end_date_after_start_date
    if start_date && end_date && end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
