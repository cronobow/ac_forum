class RepliesController < ApplicationController
  before_action :set_post
  before_action :set_reply, only: [:edit, :update, :destroy]


  def create
    if @post.draft == true
      flash[:alert] = '草稿無法留言'
    else
      @reply = @post.replies.build(reply_params)
      @reply.user = current_user
      @reply.save
    end
    redirect_to post_path(@post)
  end

  def edit
  end

  def update

  end

  def destroy
    @reply.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
