# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  notifiable_type :string(255)
#  read            :boolean          default("unread"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notifiable_id   :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_notifications_on_notifiable_type_and_notifiable_id  (notifiable_type,notifiable_id)
#  index_notifications_on_user_id                            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  enum read: { unread: false, read: true }
  scope :recent, ->(count) { order(created_at: :desc).limit(count)}

  include Rails.application.routes.url_helpers

  def call_appropriate_partial
    return "liked_to_own_output" if notifiable_type == "Like"
    return "followed_me" if notifiable_type == "Relationship"
    return "requested_to_own_meeting" if notifiable_type == "Requesting"
    return "permitted_me" if notifiable_type == "Participant"
    return "message_to_own_meeting" if notifiable_type == "Message"
  end

end
