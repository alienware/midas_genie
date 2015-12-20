# == Schema Information
#
# Table name: midas_genie_questions
#
#  id          :integer          not null, primary key
#  title       :text             not null
#  description :text
#  remark      :text
#  type        :string           not null
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'paranoia'

module MidasGenie
  class Question < ActiveRecord::Base
    acts_as_paranoid

    has_many :midas_section_questions, dependent: :destroy, class_name: 'MidasGenie::SectionQuestion'
    has_many :midas_sections, through: :midas_section_questions

    validates_presence_of :title, :type
    validates_inclusion_of :type, in: %w{MidasGenie::SingleChoiceQuestion MidasGenie::MultipleChoiceQuestion MidasGenie::NumericalQuestion MidasGenie::ShortTextualQuestion MidasGenie::LongTextualQuestion MidasGenie::DateTimeQuestion}

    def unique_id
      "Q.#{'%05d' % id}"
    end
  end
end
