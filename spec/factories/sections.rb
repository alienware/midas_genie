FactoryGirl.define do
  factory :section, class: MidasGenie::Section do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    remark { Faker::Lorem.sentence }

    trait :with_midas_questions do
      transient do
        number_of_questions 10
      end

      after(:build) do |section, evaluator|
        create_list(:section_question, evaluator.number_of_questions, midas_section: section)
        section.reload
      end
    end
  end
end
