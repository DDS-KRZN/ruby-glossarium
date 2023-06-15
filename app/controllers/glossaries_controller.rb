class GlossariesController < ApplicationController
  def index
    @glossaries = Glossary.all
  end

  def show
    @glossary = Glossary.find(params[:id])
    @words = @glossary.words
  end


  def new
    @glossary = Glossary.new
  end

  def create
    @glossary = Glossary.new(glossary_params)
    if @glossary.save
      redirect_to @glossary, notice: "Glossary was successfully created."
    else
      render :new, alert: "Glossary could not be created."
    end
  end

  def edit
    @glossary = Glossary.find(params[:id])
  end

  def update
    @glossary = Glossary.find(params[:id])
    if @glossary.update(glossary_params)
      redirect_to @glossary, notice: "Glossary was successfully updated."
    else
      render :edit, alert: "Glossary could not be updated."
    end
  end

  def destroy
    @glossary = Glossary.find(params[:id])
    @glossary.destroy
    redirect_to root_path, notice: "Glossary was successfully deleted."
  end

  private
  def glossary_params
    params.require(:glossary).permit(:name, :description, :archive)
  end
end
