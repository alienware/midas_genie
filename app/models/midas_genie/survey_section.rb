require 'paranoia'

module MidasGenie
  class SurveySection < ActiveRecord::Base
    acts_as_paranoid

    belongs_to :midas_survey, class_name: 'MidasGenie::Survey', foreign_key: 'survey_id'
    belongs_to :midas_section, class_name: 'MidasGenie::Section', foreign_key: 'section_id'
  end
end
