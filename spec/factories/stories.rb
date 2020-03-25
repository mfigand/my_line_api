FactoryBot.define do
  factory :story do
    title { "MyString" }
    date { "2020-03-24" }
    author_id { 1 }
    author_title { 1 }
    tags { "" }
    description { "MyString" }
  end
end
