class RequestingsController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    current_user.request(@meeting)
  end

  def destroy
    @meeting = Requesting.find(params[:id]).meeting
    current_user.unrequest(@meeting)
  end
end
