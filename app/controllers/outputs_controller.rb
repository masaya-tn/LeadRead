class OutputsController < ApplicationController
  def index
    @outputs = Output.all
  end

  def show
    @output = Output.find(params[:id])
  end

  def new
    @output = Output.new
    @book_title = params[:book_title]
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
    params.require(:output).permit(:title, :body, :book_title)
  end
end
