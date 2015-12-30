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

require 'rails_helper'

module MidasGenie
  describe Question do
    describe '# Associations' do
      it { should have_many(:midas_section_questions) }
      it { should have_many(:midas_survey_section_questions) }
      it { should have_many(:midas_sections).through(:midas_section_questions) }
      it { should have_many(:midas_survey_sections).through(:midas_survey_section_questions) }
    end

    describe '# Validations' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:type) }
      it { should validate_inclusion_of(:type).in_array(%w{MidasGenie::SingleChoiceQuestion MidasGenie::MultipleChoiceQuestion MidasGenie::NumericalQuestion MidasGenie::ShortTextualQuestion MidasGenie::LongTextualQuestion MidasGenie::DateTimeQuestion}) }
    end

    describe '# Unique ID' do
      subject { FactoryGirl.create(:question) }

      it { should respond_to(:unique_id) }

      its(:unique_id) { should eq('Q.00001') }
    end
  end
end
