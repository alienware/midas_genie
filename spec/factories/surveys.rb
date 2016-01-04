FactoryGirl.define do
  factory :survey, class: MidasGenie::Survey do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    remark { Faker::Lorem.sentence }

    trait :with_midas_sections do
      transient do
        number_of_sections 10
        with_midas_questions false
        number_of_questions 10
      end

      after(:build) do |survey, evaluator|
        if evaluator.with_midas_questions
          create_list(:survey_section, evaluator.number_of_sections, :with_midas_questions, midas_survey: survey, number_of_questions: evaluator.number_of_questions)
        else
          create_list(:survey_section, evaluator.number_of_sections, midas_survey: survey)
        end
        survey.reload
      end
    end
  end
end
