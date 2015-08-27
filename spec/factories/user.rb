FactoryGirl.define do
  factory :user do
    email 'bob@test.com'
    username '@bob'
    password 'password'
    password_confirmation 'password'
  end
end