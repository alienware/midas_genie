FactoryGirl.define do
  factory :multiple_choice_question, class: MidasGenie::MultipleChoiceQuestion, parent: :question do
    type 'MidasGenie::MultipleChoiceQuestion'

    trait :with_options do
      ignore do
        number_of_options 10
      end

      after(:build) do |multiple_choice_question, evaluator|
        create_list(:option, evaluator.number_of_options, midas_question: multiple_choice_question)
      end
    end
  end
end
