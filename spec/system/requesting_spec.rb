require 'rails_helper'

RSpec.describe 'リクエスト', type: :system do
  describe 'リクエスト送信' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user)}
    let!(:meeting_by_user_a) { create(:meeting, user: user_a) }
    let!(:meeting_by_user_b) { create(:meeting, user: user_b) }
    before do
      login_as user_a
    end
    
    it 'リクエストを送信できること' do
      visit meeting_path(meeting_by_user_b)
      find('.request-button').click
      expect(page).to have_css('.unrequest-button')
      expect(page).not_to have_css('.request-button')
    end

    it 'リクエストを取り消せること' do
      visit meeting_path(meeting_by_user_b)
      find('.request-button').click
      find('.unrequest-button').click
      expect(page).to have_css('.request-button')
      expect(page).not_to have_css('.unrequest-button')
    end
  end
end