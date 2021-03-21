require 'rails_helper'

RSpec.describe '読書会参加許可許可', type: :system do
  describe 'リクエスト許可' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user)}
    let!(:meeting_by_user_a) { create(:meeting, user: user_a) }
    let!(:meeting_by_user_b) { create(:meeting, user: user_b) }
    before do
      login_as user_b
      visit meeting_path(meeting_by_user_a)
      find('.request-button').click
    end

    it 'リクエストしてきたユーザーを参加許可できること' do
      login_as user_a
      visit meeting_path(meeting_by_user_a)
      find('.permit-button').click
      expect(page).to have_content('許可しました')
      expect(page).not_to have_css('.permit-button')
    end

    it 'リクエストしてきたユーザーを参加拒否できること' do
      login_as user_a
      visit meeting_path(meeting_by_user_a)
      find('.reject-button').click
      expect(page).to have_content('拒否しました')
      expect(page).not_to have_css('.reject-button')
    end
  end
end