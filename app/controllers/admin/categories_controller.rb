class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy]

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

  def destroy
    @category.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to admin_categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
