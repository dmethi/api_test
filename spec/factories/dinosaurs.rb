FactoryBot.define do
  factory :dinosaur do
    name {Faker::Name.first_name}
    species {Faker::Beer.brand}
    diet {Faker::Boolean.boolean}
    cage {0}
  end
end
