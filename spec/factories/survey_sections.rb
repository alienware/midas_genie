FactoryGirl.define do
  factory :survey_section, class: MidasGenie::SurveySection do
    midas_survey { FactoryGirl.create(:survey) }
    midas_section { FactoryGirl.create(:section) }

    trait :with_midas_questions do
      transient do
        number_of_questions 10
      end

      after(:build) do |survey_section, evaluator|
        create_list(:survey_section_question, evaluator.number_of_questions, midas_survey_section: survey_section)
        survey_section.reload
      end
    end
  end
end
