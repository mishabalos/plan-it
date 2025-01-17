# app/models/activity_log.rb
class ActivityLog < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  belongs_to :target, polymorphic: true, optional: true

  validates :action, presence: true
end