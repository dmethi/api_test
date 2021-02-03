FactoryBot.define do
  factory :cage do
    capacity {Faker::Number.within(range:30..50)}
    status {'ACTIVE'}
    num_dinos {0}
  end
end
