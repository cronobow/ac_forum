class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = 'User updated'
    else
      flash[:alert] = 'Error'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

end
