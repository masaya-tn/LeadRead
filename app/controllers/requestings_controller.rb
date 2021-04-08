class RequestingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @meeting = Meeting.find(params[:meeting_id])
    current_user.request(@meeting)
  end

  def destroy
    @meeting = Requesting.find(params[:id]).meeting
    @user = User.find(params[:user_id])
    @user.unrequest(@meeting)
  end
end
