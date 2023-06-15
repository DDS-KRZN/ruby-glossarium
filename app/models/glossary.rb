class Glossary < ApplicationRecord
  has_many :categories
  has_many :words

  def archived?
    archive == true
  end
end
