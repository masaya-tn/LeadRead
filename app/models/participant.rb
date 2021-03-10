# == Schema Information
#
# Table name: participants
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_participants_on_meeting_id              (meeting_id)
#  index_participants_on_user_id                 (user_id)
#  index_participants_on_user_id_and_meeting_id  (user_id,meeting_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (user_id => users.id)
#
class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :meeting
  has_one :notification, as: :notifiable, dependent: :destroy

end
