FactoryGirl.define do
  factory :section_question, class: MidasGenie::SectionQuestion do
    midas_question { FactoryGirl.create(:question) }
    midas_section { FactoryGirl.create(:section) }

    trait :with_position do
      transient do
        position 1
      end

      before(:create) do |section_question, evaluator|
        section_question.position = evaluator.position
      end
    end
  end
end
