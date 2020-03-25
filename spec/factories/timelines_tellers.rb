# frozen_string_literal: true

FactoryBot.define do
  factory :timelines_teller do
    timeline_id { create(:timeline).id }
    teller_id { create(:user).id }
  end
end
