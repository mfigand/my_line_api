# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end
end

FactoryBot.define do
  factory :user do
    name { 'Name' }
    lastname { 'Lastname' }
    email { generate :email }
    password { '12345678' }
  end
end
