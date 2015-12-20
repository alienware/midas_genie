# == Schema Information
#
# Table name: midas_genie_options
#
#  id                      :integer          not null, primary key
#  title                   :text             not null
#  description             :text
#  remark                  :text
#  midas_genie_question_id :integer
#  deleted_at              :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'paranoia'

module MidasGenie
  class Option < ActiveRecord::Base
    acts_as_paranoid

    belongs_to :midas_question, class_name: 'MidasGenie::Question', foreign_key: 'question_id'

    validates_presence_of :midas_question
  end
end
