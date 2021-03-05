# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :outputs, dependent: :destroy
  has_many :action_plans, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_outputs, through: :likes, source: :output
  has_many :meetings, dependent: :destroy
  has_many :requestings, dependent: :destroy
  has_many :request_meetings, through: :requestings, source: :meeting
  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy

  def own?(object)
    id == object.user_id
  end

  def like?(output)
    likes.exists?(output_id: output.id)
  end

  def like(output)
    like_outputs << output
  end

  def unlike(output)
    like_outputs.destroy(output)
  end

  def request?(meeting)
    requestings.exists?(meeting_id: meeting.id)
  end

  def request(meeting)
    request_meetings << meeting
  end

  def unrequest(meeting)
    request_meetings.destroy(meeting)
  end

  def participant?(meeting)
    participants.exists?(meeting_id: meeting.id)
  end
end
