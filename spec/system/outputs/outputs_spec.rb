require 'rails_helper'

RSpec.describe 'アウトプット', type: :system do
  describe 'アウトプット投稿' do
    it '投稿できること' do
      login
      visit new_output_path(:book_title => '本のタイトル')
      within '#output_form' do
        find('#title_form').fill_in(with: 'テスト')
        find('#body_form').fill_in(with: '本文')
        click_button '投稿'
      end
      expect(page).to have_content '投稿しました'
      expect(page).to have_content 'テスト'
    end
  end
end