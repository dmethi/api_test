class Dinosaur < ApplicationRecord
  belongs_to :cage
  # validations
  validates_presence_of :name, :is_carnivore, :species
end
