# == Schema Information
#
# Table name: outputs
#
#  id         :bigint           not null, primary key
#  author     :string(255)
#  body       :text(65535)      not null
#  book_image :string(255)
#  book_title :string(255)      not null
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_outputs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Output < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
