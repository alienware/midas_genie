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
          section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 4)
          @section_questions = section.midas_section_questions
          @section_questions[0].put_after!(@section_questions[2].id)
        end

        subject { @section_questions }

        it 'should change first question\'s position to three' do
          expect(subject[0].position).to eq(3)
        end

        it 'should change second question\'s position to first' do
          expect(subject[1].reload.position).to eq(1)
        end

        it 'should change third question\'s position to second' do
          expect(subject[2].reload.position).to eq(2)
        end

        it 'should retain fourth question\'s position of fourth' do
          expect(subject[3].reload.position).to eq(4)
        end
      end

      context 'third question put after first' do
        before(:example) do
          section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 4)
          @section_questions = section.midas_section_questions
          @section_questions[2].put_after!(@section_questions[0].id)
        end

        subject { @section_questions }

        it 'should retain first question\'s position' do
          expect(subject[0].reload.position).to eq(1)
        end

        it 'should change second question\'s position to third' do
          expect(subject[1].reload.position).to eq(3)
        end

        it 'should change third question\'s position to second' do
          expect(subject[2].position).to eq(2)
        end

        it 'should retain fourth question\'s position of fourth' do
          expect(subject[3].reload.position).to eq(4)
        end
      end

      context 'second question put before first' do
        before(:example) do
          section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 4)
          @section_questions = section.midas_section_questions
          @section_questions[1].put_before!(@section_questions[0].id)
        end

        subject { @section_questions }

        it 'should change first question\'s position to second' do
          expect(subject[0].reload.position).to eq(2)
        end

        it 'should change second question\'s position to first' do
          expect(subject[1].position).to eq(1)
        end

        it 'should retain third question\'s position of third' do
          expect(subject[2].reload.position).to eq(3)
        end

        it 'should retain fourth question\'s position of third' do
          expect(subject[3].reload.position).to eq(4)
        end
      end

      context 'first question put before third' do
        before(:example) do
          section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 4)
          @section_questions = section.midas_section_questions
          @section_questions[0].put_before!(@section_questions[2].id)
        end

        subject { @section_questions }

        it 'should change first question\'s position to second' do
          expect(subject[0].position).to eq(2)
        end

        it 'should change second question\'s position to first' do
          expect(subject[1].reload.position).to eq(1)
        end

        it 'should retain third question\'s position of third' do
          expect(subject[2].reload.position).to eq(3)
        end

        it 'should retain fourth question\'s position of third' do
          expect(subject[3].reload.position).to eq(4)
        end
      end
    end
  end
end
