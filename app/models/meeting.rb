require 'date'
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

  validates :title, presence: true
  validates :description, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :date, presence: true
  validate :before_today
  def before_today
    errors.add(:date, 'に過去の日付は登録できません') if date.present? && (date < Date.today.to_time)
  end

  def permit?(user)
    participants.exists?(user_id: user.id)
  end

  def permit(user)
    participanting_users << user
  end

  def after_now?
    date > Date.today.to_time
  end
end
