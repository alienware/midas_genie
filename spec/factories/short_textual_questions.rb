FactoryGirl.define do
  factory :short_textual_question, class: MidasGenie::ShortTextualQuestion, parent: :question do
    type 'MidasGenie::ShortTextualQuestion'
  end
end
