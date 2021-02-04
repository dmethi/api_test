class Dinosaur < ApplicationRecord
  # validations
  validates_presence_of :name, :is_carnivore, :species
end
