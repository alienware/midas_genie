require 'paranoia'
require 'acts_as_list'
require 'auto_increment'

module MidasGenie
  class SurveySection < ActiveRecord::Base
    acts_as_paranoid
    counter_culture :midas_survey, column_name: 'survey_sections_count'
    auto_increment :position, scope: :section_id, initial: 1, force: true, lock: false
    acts_as_list scope: :survey_id

    belongs_to :midas_survey, class_name: 'MidasGenie::Survey', foreign_key: 'survey_id'
    belongs_to :midas_section, class_name: 'MidasGenie::Section', foreign_key: 'section_id'
    has_many :midas_survey_section_questions, -> { order(position: :asc) }, dependent: :destroy, class_name: 'MidasGenie::SurveySectionQuestion'
    has_many :midas_questions, through: :midas_survey_section_questions

    validates_presence_of :midas_survey, :midas_section
    validates :position, uniqueness_without_deleted: { scope: :section_id }
  end
end
