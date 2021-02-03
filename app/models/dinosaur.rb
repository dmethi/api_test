class Dinosaur < ApplicationRecord

  # validations
  validates_presence_of :name, :diet, :species
end
