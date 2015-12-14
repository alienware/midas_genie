FactoryGirl.define do
  factory :question, class: MidasGenie::Question do
    title 'Fetishism cartel grenade otaku assassin math-assault alcohol nodal point. Fetishism franchise saturation point augmented reality range-rover order-flow nodal point silent warehouse courier meta-soul-delay nodality chrome. Media systema neural gang office garage Tokyo nodal point computer. Corrupted nano-dead footage knife meta-render-farm hacker motion neural tower sentient office. '
    type %w{MidasGenie::SingleChoiceQuestion MidasGenie::MultipleChoiceQuestion MidasGenie::NumericalQuestion MidasGenie::ShortTextualQuestion MidasGenie::LongTextualQuestion MidasGenie::DateTimeQuestion}.sample
  end
end
