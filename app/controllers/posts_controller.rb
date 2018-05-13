class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :collect, :uncollect]

  def index
    @posts = Post.published.all_user
    @categories = Category.all
    if params[:category].present?
      @category = params[:category]
      @posts = Category.find_by(name: params[:category]).posts
    end
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save && params[:commit] == 'Published'
      @post.draft = false
      @post.save
      flash[:notice] = '已成功發表'
      redirect_to posts_path
    elsif @post.save
      flash[:notice] = '已建立草稿'
      redirect_to edit_post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.to_sentence if @post.errors.any?
      render :new
    end
  end

  def show
    @reply = Reply.new
    @replies = @post.replies.all
    @post.viewed_count += 1
    @post.save
  end

  def edit
    @categories = Category.all
  end

  def update
    if @post.update(post_params)
      if params[:commit] == 'Published' && @post.draft == true
        @post.draft = false
        @post.save
        flash[:notice] = '已成功發表'
        redirect_back(fallback_location: root_path)
      else
        flash[:notice] = '文章已更新'
        redirect_to edit_post_path(@post)
      end
    else
      flash[:alert] = @post.errors.full_messages.to_sentence if @post.errors.any?
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Successfully deleted"
    redirect_back(fallback_location: root_path)
  end

  def collect
    collect = Collect.create(user: current_user, post: @post)
    if collect.save
      flash[:notice] = "Successfully collected"
    else
      flash[:alert] = collect.errors.full_messages.to_sentence if collect.errors.any?
    end
    redirect_back(fallback_location: root_path)
  end

  def uncollect
    collect = @post.collects.find_by(user: current_user)
    if collect.destroy
      flash[:notice] = "Successfully Uncollect"
    else
      flash[:alert] = "Error"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image, :draft, :privacy, :category_ids => [])
  end

end
