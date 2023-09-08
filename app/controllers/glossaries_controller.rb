class GlossariesController < ApplicationController
  def index
    @glossaries = Glossary.all.order(:name)
  end

  def show
    @glossary = Glossary.find(params[:id])
    @words = @glossary.words.order(:word)
    if params[:letter].present?
      @words = @words.where("word LIKE ?", "#{params[:letter]}%")
    end
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

  def export
    @glossary = Glossary.find(params[:id])
    @words = @glossary.words.order(:word)
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        pdf.font_families.update(
          "OpenSans" => {
            normal: Rails.root.join("app/assets/fonts/OpenSans-Regular.ttf"),
            bold: Rails.root.join("app/assets/fonts/OpenSans-Bold.ttf")
          }
        )
        pdf.font "OpenSans"
        pdf.text @glossary.name
        pdf.text @glossary.description
        @words.each do |word|
          pdf.text "<b>#{word.word}</b> - #{word.definition}", inline_format: true
        end
        send_data pdf.render, filename: 'glossary.pdf', type: 'application/pdf'
      end
    end
  end

  def export_txt
    @glossary = Glossary.find(params[:id])
    @words = @glossary.words.order(:word)

    file_content = @words.map { |word| "#{word.word}\t#{word.definition}" }.join("\n")

    send_data file_content, filename: 'glossary.txt', type: 'text/plain'
  end

  def import_txt
    @glossary = Glossary.find(params[:id])

    if params[:file].present?
      file_content = params[:file].read

      file_content.each_line do |line|
        word, definition = line.chomp.split("\t")
        @glossary.words.create(word: word, definition: definition)
      end

      redirect_to @glossary, notice: "Words were successfully imported."
    else
      redirect_to @glossary, alert: "Please select a file to import."
    end
  end


  private
  def glossary_params
    params.require(:glossary).permit(:name, :description, :archive)
  end
end
