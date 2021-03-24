require "rails_helper"

RSpec.describe 'アクションプラン確認メール', type: :mailer do
  describe 'action_plan_check' do
    let!(:user) { create(:user) }
    let(:mail) { UserMailer.with(user: user).check_action_plan }
    
    it 'アクションプラン確認メール送信' do
      action_plan = build(:action_plan, user: user, notion: true)
      expect(mail.subject).to eq('アクションプランの確認です')
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(['leadread@example.com'])
    end

    it 'アクションプラン確認メール本文' do
      
    end
  end
end