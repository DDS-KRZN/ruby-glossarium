class CategoriesController < ApplicationController
  before_action :set_glossary
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = @glossary.categories.order(:name)
  end

  def show
  end

  def new
    @category = @glossary.categories.new
  end

  def edit
  end

  def create
    @category = @glossary.categories.new(category_params)

    if @category.save
      redirect_to [@glossary, @category], notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to [@glossary, @category], notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to glossary_categories_url(@glossary), notice: 'Category was successfully destroyed.'
  end

  private

  def set_glossary
    @glossary = Glossary.find(params[:glossary_id])
  end

  def set_category
    @category = @glossary.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
