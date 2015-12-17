FactoryGirl.define do
  factory :long_textual_question, class: MidasGenie::LongTextualQuestion, parent: :question do
    type 'MidasGenie::LongTextualQuestion'
  end
end
