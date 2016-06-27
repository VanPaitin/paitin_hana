FactoryGirl.define do
  factory :todo do
    title { Faker::Lorem.characters(15) }
    todo { Faker::Lorem.characters(30) }
    status "Pending"
    created_at Time.now.to_s
    updated_at (Time.now + 2000).to_s
  end
end
