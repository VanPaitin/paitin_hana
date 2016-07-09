FactoryGirl.define do
  factory :todo do
    title { Faker::Lorem.characters(15) }
    todo { Faker::Lorem.characters(30) }
    status "Pending"
  end
end
