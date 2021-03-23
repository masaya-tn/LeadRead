require 'rails_helper'

RSpec.describe '通知', type: :system do
  describe '通知表示' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user)}
    let!(:output_by_user_a) { create(:output, user: user_a) }
    let!(:meeting_by_user_a) { create(:meeting, user: user_a) }
    let!(:meeting_by_user_b) { create(:meeting, user: user_b) }
    before do
      login_as user_b
    end
    
    it 'いいね通知' do
      visit output_path(output_by_user_a)
      find('.like-button').click
      login_as user_a
      visit user_path(user_a)
      find('.notification-button').click
      expect(page).to have_css('.like-notification')
    end
    
    

    it 'フォロー通知' do
      visit user_path(user_a)
      find('.follow-button').click
      login_as user_a
      visit user_path(user_a)
      find('.notification-button').click
      expect(page).to have_css('.follow-notification')
    end

    it 'リクエスト通知' do
      visit meeting_path(meeting_by_user_a)
      find('.request-button').click
      login_as user_a
      visit user_path(user_a)
      find('.notification-button').click
      expect(page).to have_css('.request-notification')
    end

    it '参加許可通知' do
      visit meeting_path(meeting_by_user_a)
      find('.request-button').click
      login_as user_a
      visit meeting_path(meeting_by_user_a)
      find('.permit-button').click
      login_as user_b
      visit user_path(user_b)
      find('.notification-button').click
      expect(page).to have_css('.permit-notification')
    end

    it 'メッセージ通知' do
      visit meeting_path(meeting_by_user_a)
      find('.request-button').click
      login_as user_a
      visit meeting_path(meeting_by_user_a)
      find('.permit-button').click
      login_as user_b
      visit meeting_path(meeting_by_user_a)
      find('.message-form').fill_in(with: 'メッセージ通知テスト')
      click_button '投稿'
      login_as user_a
      visit user_path(user_a)
      find('.notification-button').click
      expect(page).to have_css('.message-notification')
    end
  end
end