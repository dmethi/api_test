class Cage < ApplicationRecord
  has_many :dinosaurs
  # validations
  validates_presence_of :capacity

  before_create :set_params

  # scope for filtration. Assuming only cage filtration is on power status
  scope :powered_on, -> {where(:status => 'ACTIVE')}
  scope :powered_off, -> {where(:status => 'DOWN')}

  # helper methods
  # determine cage status
  def total_count
    return Dinosaur.where({cage: self.id})
  end

  def is_cage_on?
    return status == 'ACTIVE'
  end

  # determine if cage is at capacity
  def is_cage_full?
    return capacity == dinosaurs.count
  end

  # determine if cage is safe for herbivores
  def safe_for_herbivores?
    return dinosaurs.where(is_carnivore:true).count == 0
  end

  # getters + setters
  def species
    @species
  end

  def num_dinos=(num_dinos)
    @num_dinos = num_dinos
  end

  # setting basic parameters to ensure
  def set_params
    # ensures cage is empty upon creation
    self.num_dinos = 0

    # ensures status is either DOWN or ACTIVE
    if self.status != 'DOWN'
      self.status = 'ACTIVE'
    end
  end

end
