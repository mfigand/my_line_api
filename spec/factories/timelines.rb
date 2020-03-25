# frozen_string_literal: true

FactoryBot.define do
  factory :timeline do
    title { 'My Timeline' }
    protagonist_id { create(:user).id }
    author_id { create(:user).id }
  end
end
