require 'rails_helper'

module MidasGenie
  describe MultipleChoiceQuestion do
    describe '# Associations' do
      it { should have_many :midas_options }
    end
  end
end
