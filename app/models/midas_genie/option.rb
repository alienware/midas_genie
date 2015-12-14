require 'paranoia'

module MidasGenie
  class Option < ActiveRecord::Base
    acts_as_paranoid

    belongs_to :midas_question, class_name: 'MidasGenie::Question', foreign_key: 'question_id'

    validates_presence_of :midas_question
  end
end
