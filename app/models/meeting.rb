# == Schema Information
#
# Table name: meetings
#
#  id          :bigint           not null, primary key
#  capacity    :integer          not null
#  date        :datetime         not null
#  description :text(65535)      not null
#  open        :boolean          default(TRUE), not null
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_meetings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Meeting < ApplicationRecord
  belongs_to :user
  has_many :requestings, dependent: :destroy
  has_many :requesting_users, through: :requestings, source: :user
  has_many :participants, dependent: :destroy
  has_many :participanting_users, through: :participants, source: :user
  has_many :messages, dependent: :destroy

  def requested_users
    requesting_users
  end

  def permit?(user)
    participants.exists?(user_id: user.id)
  end

  def permit(user)
    participanting_users << user
  end

  def permited_users
    participanting_users
  end
end
