FactoryGirl.define do
  factory :survey, class: MidasGenie::Survey do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    remark { Faker::Lorem.sentence }
  end
end
