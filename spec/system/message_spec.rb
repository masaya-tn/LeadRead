require 'rails_helper'

RSpec.describe 'メッセージ', type: :system do
  describe 'メッセージ' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user)}
    let!(:meeting_by_user_a) { create(:meeting, user: user_a) }
    let!(:meeting_by_user_b) { create(:meeting, user: user_b) }
    before do
      login_as user_a
    end
    it '参加していなければ読書会詳細にメッセージ欄が表示されないこと' do
      visit meeting_path(meeting_by_user_b)
      expect(page).not_to have_css('.messages')
    end
    context 'メッセージ送信' do
      it '自分の読書会でメッセージを送信できること' do
        visit meeting_path(meeting_by_user_a)
        find('.message-form').fill_in(with: 'メッセージテストa')
        click_button '投稿'
        expect(page).to have_content('メッセージテストa')
      end
      
      it '参加した読書会にメッセージを送信できること' do
        visit meeting_path(meeting_by_user_b)
        find('.request-button').click
        login_as user_b
        visit meeting_path(meeting_by_user_b)
        find('.permit-button').click
        login_as user_a
        visit meeting_path(meeting_by_user_b)
        find('.message-form').fill_in(with: 'メッセージテストb')
        click_button '投稿'
        expect(page).to have_content('メッセージテストb')
      end
    end
    it 'メッセージを更新できること' do
      visit meeting_path(meeting_by_user_a)
      find('.message-form').fill_in(with: 'メッセージテスト')
      click_button '投稿'
      find('.edit-message-button').click
      within "#message-edit-modal" do
        find('.message-form').fill_in(with: 'メッセージ更新テスト')
        click_button '投稿'
      end
      expect(page).to have_content('メッセージ更新テスト')
    end
    it 'メッセージを削除できること' do
      visit meeting_path(meeting_by_user_a)
      find('.message-form').fill_in(with: 'メッセージ削除テスト')
      click_button '投稿'
      page.accept_confirm { find('.delete-message-button').click }
      expect(page).not_to have_content('メッセージ削除テスト')
    end
  end
end