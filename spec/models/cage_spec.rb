require 'rails_helper'

RSpec.describe Cage, type: :model do
  ## validation tests
  it { should validate_presence_of(:capacity) }
end
