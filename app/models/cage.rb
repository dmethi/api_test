class Cage < ApplicationRecord
  # validations
  validates_presence_of :capacity

  # scope for filtration. Assuming only cage filtration is on power status
  scope :powered_on, -> {where(:status => 'ACTIVE')}
  scope :powered_off, -> {where(:status => 'DOWN')}

  # helper methods

  # getters + setters

  # setting basic parameters to ensure

end
