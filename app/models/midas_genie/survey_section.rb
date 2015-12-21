require 'paranoia'
require 'acts_as_list'

module MidasGenie
  class SurveySection < ActiveRecord::Base
    acts_as_paranoid
    acts_as_list scope: :survey_id

    belongs_to :midas_survey, class_name: 'MidasGenie::Survey', foreign_key: 'survey_id'
    belongs_to :midas_section, class_name: 'MidasGenie::Section', foreign_key: 'section_id'
  end
end
