require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  describe 'ユーザー登録' do
    context '入力情報が正しい場合' do
      it 'ログインできること' do
        visit new_user_registration_path
        fill_in 'メールアドレス', with: 'leadread@example.com'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード確認', with: '12345678'
        click_button 'ユーザー登録'
        expect(current_path).to eq root_path
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end

    context '入力情報に誤りがある場合' do
      it 'ログインできないこと' do
        visit new_user_registration_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード確認', with: ''
        click_button 'ユーザー登録'
        expect(page).to have_content 'メールアドレスが入力されていません。'
        expect(page).to have_content 'パスワードが入力されていません。'
      end
    end
  end
end
