require 'paranoia'

module MidasGenie
  class Question < ActiveRecord::Base
    acts_as_paranoid

    has_many :midas_options, dependent: :destroy, class_name: 'MidasGenie::Option'

    validates_presence_of :title, :type
    validates_inclusion_of :type, in: %w{SingleChoiceQuestion MultipleChoiceQuestion NumericalQuestion ShortTextualQuestion LongTextualQuestion DateTimeQuestion}

    def unique_id
      "Q.#{'%05d' % self.id}"
    end
  end
end