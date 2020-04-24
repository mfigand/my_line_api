# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { 'teller' }
    resource { 'Timeline' }
    resource_id { 0 }
  end
end
