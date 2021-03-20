require 'rails_helper'

RSpec.describe 'アクションプラン', type: :system do
  describe 'アクションプラン投稿' do
    it '投稿できること' do
      login
      visit new_action_plan_path
      find('#mail_check_box').check
      find('#content_form').fill_in(with: 'アクションプランテスト')
      click_button '登録'
      expect(page).to have_content('登録しました')
      expect(page).to have_content('アクションプランテスト')
    end
  end

  describe 'アクションプラン更新' do
    let!(:user) { create(:user) }
    let!(:action_plan_by_user) { create(:action_plan, user: user) }
    before do
      login_as user
    end

    it 'アクションプランが更新できること' do
      visit edit_action_plan_path(action_plan_by_user)
      find('#mail_check_box').check
      find('#content_form').fill_in(with: 'アクションプラン更新テスト')
      click_button '登録'
      expect(page).to have_content('更新しました')
      expect(page).to have_content('アクションプラン更新テスト')
    end
  end

  describe 'アクションプラン削除' do
    let!(:user) { create(:user) }
    let!(:action_plan_by_user) { create(:action_plan, user: user) }
    before do
      login_as user
    end

    it 'アクションプランを削除できること' do
      visit action_plan_path(action_plan_by_user)
      page.accept_confirm { find('.delete-button').click }
      expect(page).to have_content('削除しました')
      expect(page).not_to have_content(action_plan_by_user.action_content)
    end
  end
end