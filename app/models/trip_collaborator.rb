class TripCollaborator < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  ROLES = %w[viewer editor]

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :trip_id }
end
