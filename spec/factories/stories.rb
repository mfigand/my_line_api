# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    title { 'My Story' }
    date { Date.parse('24/06/2020') }
    protagonist_id { create(:user).id }
    teller_id { create(:user).id }
    teller_title { 'Dad' }
    timeline_id { create(:timeline).id }
    tags { '' }
    description { 'My story description' }
  end
end
