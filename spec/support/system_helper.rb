module SystemHelper
  def login
    user = create(:user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: '12345678'
    click_button 'ログイン'
  end

  def login_as(user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: '12345678'
    click_button 'ログイン'
  end
end