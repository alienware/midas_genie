require 'rails_helper'

module MidasGenie
  describe Survey do
    describe '# Associations' do
      it { should have_many(:midas_survey_sections) }
      it { should have_many(:midas_sections).through(:midas_survey_sections) }
      it { should have_many(:midas_section_questions).through(:midas_sections) }
      it { should have_many(:midas_questions).through(:midas_section_questions) }
    end

    describe '# Validations' do
      it { should validate_presence_of(:title) }
    end
  end
end
