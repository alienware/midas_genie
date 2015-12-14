require 'rails_helper'

module MidasGenie
  describe Question do
    describe '# Associations' do
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
