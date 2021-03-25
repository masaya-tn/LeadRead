class ActionPlansController < ApplicationController
  def index
    @action_plans = current_user.action_plans.order(created_at: :desc)
  end

  def new
    @action_plan = ActionPlan.new
    @book_title = params[:book_title]
    @book_image = params[:book_image]
  end

  def create
    @action = current_user.action_plans.build(action_plan_params)
    if @action.save
      redirect_to action_plans_path, success: '登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      redirect_to new_action_plan_path(:book_title => @action.book_title, :book_image => @action.book_image), danger: 'アクションプランを入力してください'
    end
  end

  def show
    @action_plan = current_user.action_plans.find(params[:id])
  end

  def edit
    @action_plan = current_user.action_plans.find(params[:id])
  end

  def update
    @action_plan = current_user.action_plans.find(params[:id])
    if @action_plan.update(action_plan_params)
      redirect_to action_plans_path, success: '更新しました'
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @action_plan = current_user.action_plans.find(params[:id])
    @action_plan.destroy!
    redirect_to action_plans_path, success: '削除しました'
  end

  private

  def action_plan_params
    params.require(:action_plan).permit(:notice, :action_content, :book_title, :book_image)
  end
end
