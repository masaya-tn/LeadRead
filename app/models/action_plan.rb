# == Schema Information
#
# Table name: actions
#
#  id             :bigint           not null, primary key
#  action_content :text(65535)      not null
#  book_image     :string(255)
#  book_title     :string(255)      not null
#  notion         :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_actions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ActionPlan < ApplicationRecord
  belongs_to :user
end
