require 'paranoia'
require 'counter_culture'

module MidasGenie
  class SectionQuestion < ActiveRecord::Base
    acts_as_paranoid

    belongs_to :midas_question, class_name: 'MidasGenie::Question', foreign_key: 'question_id'
    belongs_to :midas_section, class_name: 'MidasGenie::Section', foreign_key: 'section_id'

    counter_culture :midas_section, column_name: 'section_questions_count'

    def put_after! section_question_id
    end

    def put_before! section_question_id
    end
  end
end
