class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all.includes(:participanting_users, :user).page(params[:page]).per(10).order(date: :desc)
    @q = Meeting.ransack(params[:q])
  end

  def search
    @q = Meeting.search(search_params)
    @meetings = @q.result(distinct: true)
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = current_user.meetings.build(meeting_params)
    if @meeting.save
      redirect_to meetings_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def edit
    @meeting = current_user.meetings.find(params[:id])
  end

  def update
    @meeting = current_user.meetings.find(params[:id])
    if @meeting.update(meeting_params)
      redirect_to meeting_path(@meeting), success: '更新しました'
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @meeting = current_user.meetings.find(params[:id])
    @meeting.destroy!
    redirect_to meetings_path, success: '削除しました'
  end

  def show
    @meeting = Meeting.find(params[:id])
    @messages = @meeting.messages
    @message = Message.new
  end

  private

  def meeting_params
    params.require(:meeting).permit(:title, :description, :date, :capacity)
  end

  def search_params
    params.require(:q).permit(:title_cont)
  end
end
