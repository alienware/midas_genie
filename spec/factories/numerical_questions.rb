FactoryGirl.define do
  factory :numerical_question, class: MidasGenie::NumericalQuestion, parent: :question do
    type 'MidasGenie::NumericalQuestion'
  end
end
