require 'rails_helper'

RSpec.describe 'フォロー、アンフォロー', type: :system do
  describe 'フォロー' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    before do
      login_as user_a
    end
    it 'フォローボタンが表示されること' do
      visit user_path(user_b)
      expect(page).to have_css('.follow-button')
    end
    it 'フォローできること' do
      visit user_path(user_b)
      find('.follow-button').click
      expect(page).to have_css('.unfollow-button')
      expect(page).not_to have_css('.follow-button')
    end
  end

  describe 'アンフォロー' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    before do
      login_as user_a
    end
    it 'アンフォローできること' do
      visit user_path(user_b)
      find('.follow-button').click
      find('.unfollow-button').click
      expect(page).to have_css('.follow-button')
      expect(page).not_to have_css('.unfollow-button')
    end
  end
end