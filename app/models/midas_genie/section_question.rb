require 'paranoia'
require 'counter_culture'
require 'paranoia_uniqueness_validator'
require 'auto_increment'
require 'acts_as_list'

module MidasGenie
  class SectionQuestion < ActiveRecord::Base
    acts_as_paranoid
    counter_culture :midas_section, column_name: 'section_questions_count'
    auto_increment :position, scope: :section_id, initial: 1, force: true, lock: false
    acts_as_list scope: :section_id

    belongs_to :midas_question, class_name: 'MidasGenie::Question', foreign_key: 'question_id'
    belongs_to :midas_section, class_name: 'MidasGenie::Section', foreign_key: 'section_id'

    validates_presence_of :midas_section, :midas_question
    validates :position, uniqueness_without_deleted: { scope: :section_id }

    def put_after! section_question_id
      other_section_question = SectionQuestion.select(:section_id, :position).find(section_question_id)
      return unless section_id.eql?(other_section_question.section_id)
      other_section_question_position = other_section_question.position
      other_section_question_position += 1 if position > other_section_question_position
      insert_at(position_in_bounds(other_section_question_position))
    end

    def put_before! section_question_id
      other_section_question = SectionQuestion.select(:section_id, :position).find(section_question_id)
      return unless section_id.eql?(other_section_question.section_id)
      other_section_question_position = other_section_question.position
      other_section_question_position -= 1 if position < other_section_question_position
      insert_at(position_in_bounds(other_section_question_position))
    end

    protected

    def position_in_bounds position
      number_of_questions = midas_section.section_questions_count
      number_of_questions += 1 unless midas_section.midas_section_questions.include?(self)
      if position <= 1
        1
      elsif position >= number_of_questions
        number_of_questions
      else
        position
      end
    end
  end
end
