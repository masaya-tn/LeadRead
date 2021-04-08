require 'rails_helper'

RSpec.describe 'ログイン、ログアウト', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン' do
    context '認証情報が正しい場合' do
      it 'ログインできること' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: '12345678'
        click_button 'ログイン'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ログインしました'
      end
    end

    context '認証情報に誤りがある場合' do
      it 'ログインできないこと' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: '87654321'
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
      end
    end
  end
end
