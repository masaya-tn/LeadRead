class UserMailer < ApplicationMailer
  def check_action_plan
    @user = params[:user]
    mail(to: @user.email, subject: 'アクションプランの確認です')
  end
end
