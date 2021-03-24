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
