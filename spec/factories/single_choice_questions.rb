FactoryGirl.define do
  factory :single_choice_question, class: MidasGenie::SingleChoiceQuestion, parent: :question do
    type 'MidasGenie::SingleChoiceQuestion'

    trait :with_options do
      transient do
        number_of_options 10
      end

      after(:build) do |single_choice_question, evaluator|
        create_list(:option, evaluator.number_of_options, midas_question: single_choice_question)
      end
    end
  end
end
