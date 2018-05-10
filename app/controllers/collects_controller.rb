class CollectsController < ApplicationController
  before_action :set_post

  def create
    collect = Collect.new
    collect.user = current_user
    collect.post = @post
    collect.save!

    redirect_to post_path(@post)
  end

  def destroy
    collect = Post.find(params[:id])
    collect.destroy!

    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def collect_params
    params.require(:collect).permit(:user_id, :post_id)
  end

end
