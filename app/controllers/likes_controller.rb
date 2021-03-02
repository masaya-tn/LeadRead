class LikesController < ApplicationController
  def create
    @output = Output.find(params[:output_id])
    @output.likes.create!(user_id: current_user.id)
  end

  def destroy
    @output = Like.find(params[:id]).output
    current_user.unlike(@output)
  end
end