# == Schema Information
#
# Table name: action_plans
#
#  id             :bigint           not null, primary key
#  action_content :text(65535)      not null
#  book_image     :string(255)
#  book_title     :string(255)      not null
#  notice         :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_action_plans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ActionPlan < ApplicationRecord
  belongs_to :user

  validates :action_content, presence: true
end
