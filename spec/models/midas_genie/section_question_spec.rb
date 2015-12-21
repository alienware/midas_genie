require 'rails_helper'

module MidasGenie
  describe SectionQuestion do
    describe '# Associations' do
      it { should belong_to(:midas_section) }
      it { should belong_to(:midas_question) }
    end

    describe '# Validations' do
      it { should validate_presence_of(:midas_section) }
      it { should validate_presence_of(:midas_question) }
      it { should validate_uniqueness_of(:position).scoped_to([:section_id, :deleted_at]) }
    end

    describe '# Instance methods' do
      subject { FactoryGirl.create(:section_question) }

      it { should respond_to(:put_after!).with(1).argument }
      it { should respond_to(:put_before!).with(1).argument }
    end

    describe '# Positioning' do
      context 'first question put after third' do
        before(:example) do
          section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 3)
          @section_questions = section.midas_section_questions
          @section_questions[0].put_after!(@section_questions[2].id)
        end

        subject { @section_questions }

        it 'should change first\'s position to three' do
          expect(subject[0].position).to eq(3)
        end

        it 'should change second\'s position to first' do
          expect(subject[1].reload.position).to eq(1)
        end

        it 'should change third\'s position to second' do
          subject[2].reload
          expect(subject[2].reload.position).to eq(2)
        end
      end

      context 'second question put before first' do
        before(:example) do
          section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 3)
          @section_questions = section.midas_section_questions
          @section_questions[1].put_before!(@section_questions[0].id)
        end

        subject { @section_questions }

        it 'should change first\'s position to second' do
          expect(subject[0].reload.position).to eq(2)
        end

        it 'should change second\'s position to first' do
          expect(subject[1].position).to eq(1)
        end

        it 'should retain third\'s position of third' do
          subject[2].reload
          expect(subject[2].reload.position).to eq(3)
        end
      end

      context 'question that belongs to another section' do
        context 'it is put after' do
          before(:example) do
            section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 3)
            section_questions = section.midas_section_questions
            another_section_question = FactoryGirl.create(:section_question)
            another_section_question.put_after!(section_questions[1].id)
            @subjects = [section_questions, another_section_question]
          end

          subject { @subjects }

          it 'should not be valid' do
            expect(@subjects[1]).to_not be_valid
          end

          it 'should have an error on position' do
            expect(@subjects[1]).to have(1).error_on(:position)
          end

          it 'should have an error message' do
            @subjects[1].valid?
            expect(@subjects[1].errors.messages[:position]).to include('cannot be in another section')
          end
        end

        context 'it is put before' do
          before(:example) do
            section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 3)
            section_questions = section.midas_section_questions
            another_section_question = FactoryGirl.create(:section_question)
            another_section_question.put_before!(section_questions[0].id)
            @subjects = [section_questions, another_section_question]
          end

          subject { @subjects }

          it 'should not be valid' do
            expect(@subjects[1]).to_not be_valid
          end

          it 'should have an error on position' do
            expect(@subjects[1]).to have(1).error_on(:position)
          end

          it 'should have an error message' do
            @subjects[1].valid?
            expect(@subjects[1].errors.messages[:position]).to include('cannot be in another section')
          end
        end
      end
    end
  end
end
