require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
  ## validation tests
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:species)}
  it {should validate_presence_of(:diet)}
end
