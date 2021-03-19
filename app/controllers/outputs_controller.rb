class OutputsController < ApplicationController
  before_action :require_current_user

  def index
    @outputs = Output.all.page(params[:page]).per(20).order(created_at: :desc)
    @q = Output.ransack(params[:q])
  end

  def search
    @q = Output.search(search_params)
    @outputs = @q.result(distinct: true)
  end

  def show
    @output = Output.find(params[:id])
  end

  def new
    @output = Output.new
    @book_title = params[:book_title]
    @authors = params[:author]
    @book_image = params[:book_image]
  end

  def create
    @output = current_user.outputs.build(output_params)
    if @output.save
      redirect_to outputs_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def edit
    @output = current_user.outputs.find(params[:id])
  end

  def update
    @output = current_user.outputs.find(params[:id])
    if @output.update(output_params)
      redirect_to outputs_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @output = current_user.outputs.find(params[:id])
    @output.destroy!
    redirect_to outputs_path, success: '投稿を削除しました'
  end

  private

  def output_params
    params.require(:output).permit(:title, :body, :book_title, :author, :book_image)
  end

  def search_params
    params.require(:q).permit(:title_cont, :book_title_cont)
  end

  def require_current_user
    unless current_user
      redirect_to controller: :toppages, action: :index
    end
  end
end
