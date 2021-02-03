FactoryBot.define do
  factory :dinosaur do
    name {Faker::Name.first_name}
    species {Faker::Beer.brand}
    is_carnivore {Faker::Boolean.boolean}
    cage {0}
  end
end
