FactoryGirl.define do
  factory :survey_section_question, class: MidasGenie::SurveySectionQuestion do
    midas_question { FactoryGirl.create(:question) }
    midas_survey_section { FactoryGirl.create(:survey_section) }

    trait :with_position do
      transient do
        position 1
      end

      before(:create) do |survey_section_question, evaluator|
        survey_section_question.position = evaluator.position
      end
    end
  end
end
