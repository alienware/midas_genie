require 'rails_helper'

module MidasGenie
  describe Question do

    describe '# Associations' do
      it { should have_many :midas_options }
    end

    describe '# Validations' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:type) }
      it { should validate_inclusion_of(:type).in_array(%w{SingleChoiceQuestion MultipleChoiceQuestion NumericalQuestion ShortTextualQuestion LongTextualQuestion DateTimeQuestion}) }
    end

    describe '# Unique ID' do
      subject { FactoryGirl.create(:question).unique_id }

      it 'should respond to unique_id' do
        is_expected.to be_kind_of(String)
      end

      it 'should be formatted' do
        is_expected.to eq('Q.00001')
      end
    end

  end
end