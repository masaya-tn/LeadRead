class ActionsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @action = Action.new
    @book_title = params[:book_title]
    @book_image = params[:book_image]
  end

  def create
    @action = current_user.actions.build(action_params)
    if @action.save
      redirect_to actions_path, success: '登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  private

  def action_params
    params.require(:action).permit(:notion, :action_content, :book_title, :book_image)
  end
end
