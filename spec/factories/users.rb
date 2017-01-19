FactoryGirl.define do
  factory :user do
    email         Faker::Internet.email
    password      Faker::Internet.password(8)
    first_name    Faker::Name.first_name
    last_name     Faker::Name.last_name
    role          :user
    confirmed_at  Faker::Time.backward(10, :morning)
    updated_at    Faker::Time.backward(6, :evening)
    created_at    Faker::Time.backward(11, :morning)

    trait :admin do
      email       Faker::Internet.email
      role        :admin
    end
  end
end
