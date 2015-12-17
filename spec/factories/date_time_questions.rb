FactoryGirl.define do
  factory :date_time_question, class: MidasGenie::DateTimeQuestion, parent: :question do
    type 'MidasGenie::DateTimeQuestion'
  end
end
