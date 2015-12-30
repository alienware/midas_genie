require 'paranoia'
require 'counter_culture'
require 'paranoia_uniqueness_validator'
require 'auto_increment'
require 'acts_as_list'

module MidasGenie
  class SurveySectionQuestion < ActiveRecord::Base
    acts_as_paranoid
    counter_culture :midas_survey_section, column_name: 'survey_section_questions_count'
    auto_increment :position, scope: :survey_section_id, initial: 1, force: true, lock: false
    acts_as_list scope: :survey_section_id

    belongs_to :midas_question, class_name: 'MidasGenie::Question', foreign_key: 'question_id'
    belongs_to :midas_survey_section, class_name: 'MidasGenie::SurveySection', foreign_key: 'survey_section_id'

    validates_presence_of :midas_survey_section, :midas_question
    validates :position, uniqueness_without_deleted: { scope: :survey_section_id }

    def shift_survey_section! survey_section_question_id
      other_survey_section_question = SurveySectionQuestion.select(:survey_section_id).find(survey_section_question_id)
      other_survey_section_id = other_survey_section_question.survey_section_id
      return false unless midas_survey_section.survey_id.eql?(other_survey_section_question.midas_survey_section.survey_id)
      unless survey_section_id.eql?(other_survey_section_id)
        remove_from_list
        update(survey_section_id: other_survey_section_id)
      end
      true
    end

    def put_after! survey_section_question_id
      other_survey_section_question = SurveySectionQuestion.select(:survey_section_id, :position).find(survey_section_question_id)
      shift_allowed = shift_survey_section!(survey_section_question_id)
      return unless shift_allowed
      other_survey_section_question_position = other_survey_section_question.position
      other_survey_section_question_position += 1 if position > other_survey_section_question_position
      insert_at(position_in_bounds(other_survey_section_question_position))
    end

    def put_before! survey_section_question_id
      other_survey_section_question = SurveySectionQuestion.select(:survey_section_id, :position).find(survey_section_question_id)
      shift_allowed = shift_survey_section!(survey_section_question_id)
      return unless shift_allowed
      other_survey_section_question_position = other_survey_section_question.position
      other_survey_section_question_position -= 1 if position < other_survey_section_question_position
      insert_at(position_in_bounds(other_survey_section_question_position))
    end

    protected

    def position_in_bounds position
      number_of_questions = midas_survey_section.survey_section_questions_count
      number_of_questions += 1 unless midas_survey_section.midas_survey_section_questions.include?(self)
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
