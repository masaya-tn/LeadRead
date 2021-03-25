# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_messages_on_meeting_id  (meeting_id)
#  index_messages_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :message do
    body { 'aaaaaa' }
    user
    meeting
  end
end
