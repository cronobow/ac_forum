class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
