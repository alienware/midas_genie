require 'paranoia'

module MidasGenie
  class Section < ActiveRecord::Base
    acts_as_paranoid

    has_many :midas_survey_sections, dependent: :destroy, class_name: 'MidasGenie::SurveySection'
    has_many :midas_surveys, through: :midas_survey_sections
    has_many :midas_section_questions, dependent: :destroy, class_name: 'MidasGenie::SectionQuestion'
    has_many :midas_questions, through: :midas_section_questions

    validates_presence_of :title
  end
end
