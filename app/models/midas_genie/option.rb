require 'paranoia'

module MidasGenie
  class Option < ActiveRecord::Base
    acts_as_paranoid

    belongs_to :midas_question, foreign_key: 'question_id', class_name: 'MidasGenie::Question'

    validates_presence_of :midas_question

  end
end
