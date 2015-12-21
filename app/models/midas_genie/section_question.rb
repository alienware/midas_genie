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

    attr_accessor :another_section_transfer, :out_of_bound

    belongs_to :midas_question, class_name: 'MidasGenie::Question', foreign_key: 'question_id'
    belongs_to :midas_section, class_name: 'MidasGenie::Section', foreign_key: 'section_id'

    validates_presence_of :midas_section, :midas_question
    validates :position, uniqueness_without_deleted: { scope: :section_id }
    validate :position_invalid, if: :another_section_transfer
    validate :position_out_of_bound, if: :out_of_bound

    def put_at! section_question_id
      other_section_question = SectionQuestion.select(:section_id, :position).find(section_question_id)
      if section_id.eql?(other_section_question.section_id)
        insert_at(other_section_question.position)
      else
        self.another_section_transfer = true
        false
      end
    end

    def put_after! section_question_id
      put_at!(section_question_id)
    end

    def put_before! section_question_id
      put_at!(section_question_id)
    end

    protected

    def position_invalid
      errors.add(:position, 'cannot be in another section')
    end

    def position_out_of_bound
      errors.add(:position, 'is out of bound')
    end
  end
end
