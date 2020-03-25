# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { 'My Role' }
    resource { 'some_resource' }
    resource_id { 1 }
  end
end
