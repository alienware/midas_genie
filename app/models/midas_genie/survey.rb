require 'paranoia'

module MidasGenie
  class Survey < ActiveRecord::Base
    acts_as_paranoid

    validates_presence_of :title

    has_many :midas_survey_sections, -> { order(position: :asc) }, dependent: :destroy, class_name: 'MidasGenie::SurveySection'
    has_many :midas_sections, through: :midas_survey_sections
    has_many :midas_section_questions, through: :midas_sections, class_name: 'MidasGenie::SectionQuestion'
    has_many :midas_questions, through: :midas_section_questions
  end
end
