# Модель Word с валидациями, коллбэками и ассоциациями
class Word < ApplicationRecord
  # Валидация на наличие и уникальность названия слова в рамках одного глоссария
  validates :word, presence: true, uniqueness: { scope: :glossary_id }

  # Коллбэк для удаления пробелов в начале и конце названия и описания слова
  before_validation :strip_whitespace

  # Ассоциация с моделью Glossary - одно слово принадлежит одному глоссарию
  belongs_to :glossary

  has_many :category_words
  has_many :categories, through: :category_words

  # Ассоциация с моделью Category - одно слово может принадлежать к нескольким категориям
  # has_and_belongs_to_many :categories

  # Метод для удаления пробелов в начале и конце названия и описания слова
  def strip_whitespace
    self.word = word.strip unless word.nil?
    self.definition = definition.strip unless definition.nil?
  end

end
