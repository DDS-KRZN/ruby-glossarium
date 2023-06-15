class Glossary < ApplicationRecord
  has_many :words

  def archived?
    archive == true
  end
end
