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
require 'rails_helper'

RSpec.describe ActionPlan, type: :model do
  describe 'バリデーション' do
    it '本文があれば有効であること' do
      action_plan = build(:action_plan)
      expect(action_plan).to be_valid
    end

    it '本文が必須であること' do
      action_plan = build(:action_plan, action_content: nil)
      action_plan.valid?
      expect(action_plan.errors[:action_content]).to include('が入力されていません。')
    end
  end
end
