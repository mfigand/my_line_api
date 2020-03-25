# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { 'MyString' }
    resource { 'MyString' }
    resource_id { 1 }
  end
end
