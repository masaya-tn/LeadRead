# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  uid                    :string(255)
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
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[twitter]

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
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :notifications, dependent: :destroy

  # VALID_PASSWORD_REGEX = /^[0-9a-zA-Z]*$/
  # validates :password, format: {with: VALID_PASSWORD_REGEX}

  def self.find_or_create_from_oauth(auth)
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.username = auth.info.nickname
      user.avatar = auth.info.image
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
    end
  end

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

  def follow(other_user)
    followings << other_user
  end

  def unfollow(other_user)
    followings.destroy(other_user)
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = 'ゲストさん'
    end
  end
end
