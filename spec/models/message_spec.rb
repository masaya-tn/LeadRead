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
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'バリデーション' do
    it '本文があれば有効であること' do
      message = build(:message)
      expect(message).to be_valid
    end

    it '本文が必須であること' do
      message = build(:message, body: nil)
      message.valid?
      expect(message.errors[:body]).to include('が入力されていません。')
    end
  end
end
