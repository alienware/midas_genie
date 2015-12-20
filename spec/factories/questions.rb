FactoryGirl.define do
  factory :question, class: MidasGenie::Question do
    title { Faker::Lorem.sentence }
    type %w{MidasGenie::SingleChoiceQuestion MidasGenie::MultipleChoiceQuestion MidasGenie::NumericalQuestion MidasGenie::ShortTextualQuestion MidasGenie::LongTextualQuestion MidasGenie::DateTimeQuestion}.sample
  end
end
