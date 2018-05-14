class RepliesController < ApplicationController
  before_action :set_post
  before_action :set_reply, only: [:edit, :update, :destroy]


  def create
    if @post.draft == true
      flash[:alert] = '草稿無法留言'
    else
      @reply = @post.replies.build(reply_params)
      @reply.user = current_user
      if @reply.save
        flash[:notice] = '留言已發表'
      else
        flash[:alert] = @reply.errors.full_messages.to_sentence if @reply.errors.any?
      end
    end
    redirect_to post_path(@post)
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @reply.update(reply_params)
      flash[:notice] = '留言已更新'
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence if @reply.errors.any?
    end
    redirect_to post_path(@post)
  end

  def destroy
    @reply.destroy
    flash[:notice] = "Successfully deleted"
    redirect_back(fallback_location: root_path)
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
