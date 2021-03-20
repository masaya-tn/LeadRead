require 'rails_helper'
require 'date'

RSpec.describe '読書会', type: :system do
  describe '読書会投稿' do
    it '投稿できること' do
      login
      visit new_meeting_path
      find('#title_form').fill_in(with: '読書会テスト')
      find('#description_form').fill_in(with: '本文')
      find('#capacity_form').fill_in(with: 5)
      find('#date_form').fill_in(with: Date.tomorrow.to_time)
      click_button('投稿')
      expect(page).to have_content('投稿しました')
      expect(page).to have_content('読書会テスト')
    end
  end

  describe '読書会更新' do
    let!(:user) { create(:user) }
    let!(:meeting_by_others) { create(:meeting) }
    let!(:meeting_by_user) { create(:meeting, user: user) }
    before do
      login_as user
    end
     
    it '自分の投稿に編集ボタンが表示されること' do
      visit meeting_path(meeting_by_user)
      expect(page).to have_css('.edit-button')
    end

    it '他人の投稿には編集ボタンが表示されないこと' do
      visit meeting_path(meeting_by_others)
      expect(page).not_to have_css('.edit-button')
    end

    it '更新できること' do
      visit edit_meeting_path(meeting_by_user)
      find('#title_form').fill_in(with: '読書会更新テスト')
      find('#description_form').fill_in(with: 'editmeeting')
      find('#capacity_form').fill_in(with: 6)
      find('#date_form').fill_in(with: Date.tomorrow.to_time)
      click_button('投稿')
      expect(page).to have_content('更新しました')
      expect(page).to have_content('読書会更新テスト')
    end
  end

  describe '読書会削除' do
    let!(:user) { create(:user) }
    let!(:meeting_by_others) { create(:meeting) }
    let!(:meeting_by_user) { create(:meeting, user: user) }
    before do
      login_as user
    end
     
    it '自分の投稿に削除ボタンが表示されること' do
      visit meeting_path(meeting_by_user)
      expect(page).to have_css('.delete-button')
    end

    it '他人の投稿には削除ボタンが表示されないこと' do
      visit meeting_path(meeting_by_others)
      expect(page).not_to have_css('.delete-button')
    end

    it '削除できること' do
      visit meeting_path(meeting_by_user)
      page.accept_confirm { find('.delete-button').click }
      expect(page).to have_content('削除しました')
      expect(page).not_to have_content(meeting_by_user.title)
    end
  end
end