module MidasGenie
  class MultipleChoiceQuestion < MidasGenie::Question
    has_many :midas_options, dependent: :destroy, class_name: 'MidasGenie::Option', foreign_key: 'question_id'
  end
end
