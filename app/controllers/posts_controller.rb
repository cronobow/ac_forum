class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Successfully saved"
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages.to_sentence if @post.errors.any?
      render :new
    end
  end

  def show
    @reply = Reply.new
    @replies = @post.replies.all
  end

  def edit
    @categories = Category.all
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Successfully updated"
      redirect_to posts_path
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence if @post.errors.any?
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image, :draft, :category_ids => [])
  end

end
