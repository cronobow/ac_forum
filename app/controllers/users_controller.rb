class UsersController < ApplicationController
  before_action :set_user

  def show
    @posts = @user.posts.published
  end

  def edit
    unless @user == current_user
      flash[:alert] = '沒有權限'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updated"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence if @user.errors.any?
      render :edit
    end
  end

  def show_comment
    @comments = @user.replies
    render :show
  end

  def show_collect
    if @user == current_user
      @collects = @user.collect_posts
      render :show
    else
      flash[:alert] = '沒有權限'
      redirect_back(fallback_location: root_path)
    end
  end

  def show_draft
    if @user == current_user
      @drafts = @user.posts.draft
      render :show
    else
      flash[:alert] = '沒有觀看權限'
      redirect_back(fallback_location: root_path)
    end
  end

  def show_friend
    if @user == current_user
      @waiting_friends = current_user.friends.where.not('friendships.invite = ?', 'accept')
      @invitee_friends = current_user.frienders.where('friendships.invite = ?', 'pending')
      @friends = current_user.friends.where('friendships.invite = ?', 'accept')
      render :show
    else
      flash[:alert] = '沒有觀看權限'
      redirect_back(fallback_location: root_path)
    end
  end

  def invite_friend
    if @user == current_user
      flash[:alert] = '無法邀請自己'
      redirect_back(fallback_location: root_path)
    else
      friendship = Friendship.create(user: current_user, friend: @user)
      if friendship.save
        flash[:notice] = "已送出邀請"
      else
        flash[:alert] = friendship.errors.full_messages.to_sentence if friendship.errors.any?
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def accept_friend
    friendship = Friendship.find_by(user: @user , friend: current_user)
    friendship.invite = 'accept'
    if friendship.save
      @invitee_friends = current_user.frienders.where('friendships.invite = ?', 'pending')
      flash[:notice] = "已同意邀請"
    else
      flash[:alert] = friendship.errors.full_messages.to_sentence if friendship.errors.any?
      redirect_back(fallback_location: root_path)
    end

    respond_to do |format|
      format.js
    end
  end

  def ignore_friend
    friendship = Friendship.find_by(user: @user, friend: current_user)
    friendship.invite = 'ignore'
    if friendship.save
      @invitee_friends = current_user.frienders.where('friendships.invite = ?', 'pending')
      flash[:notice] = "已忽略邀請"
    else
      flash[:alert] = friendship.errors.full_messages.to_sentence if friendship.errors.any?
      redirect_back(fallback_location: root_path)
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :description, :avatar)
  end
end
