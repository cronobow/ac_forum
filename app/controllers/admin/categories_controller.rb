class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, except: [:index, :create]

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Successfully saved"
    else
      flash[:alert] = @category.errors.full_messages.to_sentence if @category.errors.any?
    end
    redirect_to admin_categories_path
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = '分類已更新'
      redirect_to admin_categories_path
    else
      flash[:alert] = @category.errors.full_messages.to_sentence if @category.errors.any?
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Successfully deleted"
      redirect_to admin_categories_path
    else
      flash[:alert] = "無法刪除"
      redirect_to admin_categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
