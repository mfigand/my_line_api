# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { 'Teller' }
    resource { 'Timeline' }
    resource_id { 0 }
  end
end
