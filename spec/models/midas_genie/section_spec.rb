require 'rails_helper'

module MidasGenie
  describe Section do
    describe '# Associations' do
      it { should have_many(:midas_survey_sections) }
      it { should have_many(:midas_surveys).through(:midas_survey_sections) }
      it { should have_many(:midas_section_questions) }
      it { should have_many(:midas_questions).through(:midas_section_questions) }
    end

    describe '# Validations' do
      it { should validate_presence_of(:title) }
    end

    describe '# Section questions count' do
      subject { FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 2) }

      it { should respond_to(:section_questions_count) }

      its(:section_questions_count) { should eq(2) }
    end
  end
end
