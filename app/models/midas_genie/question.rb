require 'paranoia'

module MidasGenie
  class Question < ActiveRecord::Base
    acts_as_paranoid

    validates_presence_of :title, :type
    validates_inclusion_of :type, in: %w{MidasGenie::SingleChoiceQuestion MidasGenie::MultipleChoiceQuestion MidasGenie::NumericalQuestion MidasGenie::ShortTextualQuestion MidasGenie::LongTextualQuestion MidasGenie::DateTimeQuestion}

    def unique_id
      "Q.#{'%05d' % id}"
    end
  end
end