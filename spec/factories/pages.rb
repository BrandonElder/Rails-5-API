FactoryGirl.define do
  factory :page do
    page_url { Faker::Internet.url }
  end
end