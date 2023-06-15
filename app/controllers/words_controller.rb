class WordsController < ApplicationController
  def index
    @glossary = Glossary.find(params[:glossary_id])
    @words = @glossary.words.order(:word)
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @words = @words.where(categories: { id: @category.id })
    end
  end

  def show
    @word = Word.find(params[:id])
  end

  def new
    @glossary = Glossary.find(params[:glossary_id])
    @word = @glossary.words.build
    @categories = @glossary.categories.order(:name)
  end

  def create
    @glossary = Glossary.find(params[:glossary_id])
    @word = @glossary.words.build(word_params)
    if @word.save
      redirect_to [@glossary, @word], notice: "Word was successfully created."
    else
      render :new, alert: "Word could not be created."
    end
  end

  def edit
    @word = Word.find(params[:id])
    @categories = @word.glossary.categories.order(:name)
  end

  def update
    @word = Word.find(params[:id])
    if @word.update(word_params)
      redirect_to [@word.glossary, @word], notice: "Word was successfully updated."
    else
      render :edit, alert: "Word could not be updated."
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to glossary_words_path(@word.glossary), notice: "Word was successfully deleted."
  end

  private

  def word_params
    params.require(:word).permit(:word, :definition, category_ids: [])
  end
end
