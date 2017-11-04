FactoryGirl.define do
  factory :page_content do
    content { Faker::Lorem.words(4) }
    tag { Faker::Lorem.words(1)}
    page_id nil
  end
end