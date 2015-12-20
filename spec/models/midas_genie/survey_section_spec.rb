require 'rails_helper'

module MidasGenie
  describe SurveySection do
    describe '# Associations' do
      it { should(belong_to(:midas_section)) }
      it { should(belong_to(:midas_survey)) }
    end
  end
end
