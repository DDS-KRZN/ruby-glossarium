# Модель Word с валидациями, коллбэками и ассоциациями
class Word < ApplicationRecord
  validates :word, presence: true, uniqueness: { scope: :glossary_id }

  before_validation :strip_whitespace

  belongs_to :glossary

  has_many :category_words
  has_many :categories, through: :category_words

  def strip_whitespace
    self.word = word.strip unless word.nil?
    self.definition = definition.strip unless definition.nil?
  end

end
