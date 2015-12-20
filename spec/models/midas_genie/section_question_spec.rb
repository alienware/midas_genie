require 'rails_helper'

module MidasGenie
  describe SectionQuestion do
    describe '# Associations' do
      it { should belong_to(:midas_section) }
      it { should belong_to(:midas_question) }
    end

    describe '# Positioning ' do
      section = FactoryGirl.create(:section)
      first_question = FactoryGirl.create(:section_question, :with_position, position: 1, midas_section: section)
      second_question = FactoryGirl.create(:section_question, :with_position, position: 2, midas_section: section)
      third_question = FactoryGirl.create(:section_question, :with_position, position: 3, midas_section: section)

      it { should respond_to(:put_after!).with(1).argument }

      context 'first question is put after third' do
        subject { first_question }
        first_question.put_after!(third_question.id)

        its(:position) { should eq(3) }

        it 'should make second question first' do
          expect(second_question.position).to eq(1)
        end

        it 'should make third question second' do
          expect(third_question.position).to eq(2)
        end
      end

      it { should respond_to(:put_before!).with(1).argument }

      context 'second question is put before first' do
        subject { second_question }
        second_question.put_before!(first_question.id)

        its(:position) { should eq(1) }

        it 'should make first question second' do
          expect(first_question.position).to eq(2)
        end

        it 'should let third question third' do
          expect(third_question.position).to eq(3)
        end
      end

    end
  end
end
