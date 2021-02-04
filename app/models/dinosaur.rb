class Dinosaur < ApplicationRecord
  # validations
  validates_presence_of :name, :species

  # helper methods

  def is_carnivore?
    return self.is_carnivore
  end
end
