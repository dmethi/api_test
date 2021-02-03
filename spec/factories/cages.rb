FactoryBot.define do
  factory :cage do
    capacity {Faker::Number.within(range:30..50)}
    state {Faker::Boolean.boolean}
    num_dinos {0}
  end
end
