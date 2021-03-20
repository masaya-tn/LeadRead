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

  describe 'アウトプット更新' do
    let!(:user) { create(:user) }
    let!(:output_by_others) { create(:output) }
    let!(:output_by_user) { create(:output, user: user) }
    before do
      login_as user
    end

    it '自分の投稿に編集ボタンが表示されること' do
      visit output_path(output_by_user)
      expect(page).to have_css('.edit-button')
    end

    it '他人の投稿には編集ボタンが表示されないこと' do
      visit output_path(output_by_others) 
      expect(page).not_to have_css('.edit-button')
    end

    it '投稿が更新できること' do
      visit edit_output_path(output_by_user)
      find('#title_form').fill_in(with: '更新テスト')
      find('#body_form').fill_in(with: 'This is an example updated output')
      click_button '投稿'
      expect(page).to have_content '投稿を更新しました'
      expect(page).to have_content('更新テスト')
    end
  end

  describe 'アウトプット削除' do
    let!(:user) { create(:user) }
    let!(:output_by_others) { create(:output) }
    let!(:output_by_user) { create(:output, user: user) }
    before do
      login_as user
    end

    it '自分の投稿に削除ボタンが表示されること' do
      visit output_path(output_by_user)
      expect(page).to have_css('.delete-button')
    end

    it '他人の投稿には削除ボタンが表示されないこと' do
      visit output_path(output_by_others)
      expect(page).not_to have_css('.delete-button')
    end

    it '投稿が削除できること' do
      visit output_path(output_by_user)
      page.accept_confirm { find('.delete-button').click }
      expect(page).to have_content('投稿を削除しました')
      expect(page).not_to have_content(output_by_user.title)
    end
  end
end