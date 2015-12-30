require 'rails_helper'

module MidasGenie
  describe SurveySectionQuestion do
    describe '# Associations' do
      it { should belong_to(:midas_survey_section) }
      it { should belong_to(:midas_question) }
    end

    describe '# Validations' do
      it { should validate_presence_of(:midas_survey_section) }
      it { should validate_presence_of(:midas_question) }
      it { should validate_uniqueness_of(:position).scoped_to([:survey_section_id, :deleted_at]) }
    end

    describe '# Instance methods' do
      subject { FactoryGirl.create(:section_question) }

      it { should respond_to(:put_after!).with(1).argument }
      it { should respond_to(:put_before!).with(1).argument }
    end

    describe '# Positioning' do
      context 'first question put after third' do
        before(:example) do
          survey_section = FactoryGirl.create(:survey_section, :with_midas_questions, number_of_questions: 4)
          @section_questions = survey_section.midas_survey_section_questions
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
          survey_section = FactoryGirl.create(:survey_section, :with_midas_questions, number_of_questions: 4)
          @section_questions = survey_section.midas_survey_section_questions
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
          survey_section = FactoryGirl.create(:survey_section, :with_midas_questions, number_of_questions: 4)
          @section_questions = survey_section.midas_survey_section_questions
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
          survey_section = FactoryGirl.create(:survey_section, :with_midas_questions, number_of_questions: 4)
          @section_questions = survey_section.midas_survey_section_questions
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

      context 'question that belongs to another section' do
        context 'sections belong to the same survey' do
          context 'first question in first section put after second question in second section' do
            before(:example) do
              survey = FactoryGirl.create(:survey, :with_midas_sections, number_of_sections: 2, with_midas_questions: true)
              first_survey_section, second_survey_section = survey.midas_survey_sections
              first_survey_section.midas_survey_section_questions[0].put_after!(second_survey_section.midas_survey_section_questions[1].id)
              @subjects = [first_survey_section, second_survey_section]
            end

            subject { @subjects }

            it 'should make subject question\'s section to second section' do
              expect(subject[0].midas_survey_section_questions[0].survey_section_id).to eq(subject[1].id)
            end

            it 'should make subject question\'s position third' do
              expect(subject[0].midas_survey_section_questions[0].position).to eq(3)
            end

            it 'should decrement subject question\'s next question\'s position by 1' do
              expect(subject[0].midas_survey_section_questions[1].reload.position).to eq(1)
            end

            it 'should retain target questions\'s position of third' do
              expect(subject[1].midas_survey_section_questions[1].reload.position).to eq(2)
            end

            it 'should increment target question\'s next question\'s position by 1' do
              expect(subject[1].midas_survey_section_questions[2].reload.position).to eq(4)
            end

            it 'should decrement subject question\'s section\'s questions count by 1' do
              expect(subject[0].midas_survey_section_questions.count).to eq(9)
            end

            it 'should increment target question\'s section\'s questions count by 1' do
              expect(subject[1].midas_survey_section_questions.count).to eq(11)
            end
          end

          context 'third question in first section put before fourth question in second section' do
            before(:example) do
              survey = FactoryGirl.create(:survey, :with_midas_sections, number_of_sections: 2, with_midas_questions: true)
              first_survey_section, second_survey_section = survey.midas_survey_sections
              first_survey_section.midas_survey_section_questions[2].put_before!(second_survey_section.midas_survey_section_questions[3].id)
              @subjects = [first_survey_section, second_survey_section]
            end

            subject { @subjects }

            it 'should make subject question\'s section to second section' do
              expect(subject[0].midas_survey_section_questions[2].survey_section_id).to eq(subject[1].id)
            end

            it 'should make subject question\'s position fourth' do
              expect(subject[0].midas_survey_section_questions[2].position).to eq(4)
            end

            it 'should decrement subject question\'s next question\'s position by 1' do
              expect(subject[0].midas_survey_section_questions[3].reload.position).to eq(3)
            end

            it 'should increment target questions\'s position by 1' do
              expect(subject[1].midas_survey_section_questions[3].reload.position).to eq(5)
            end

            it 'should retain target question\'s previous question\'s position of third' do
              expect(subject[1].midas_survey_section_questions[2].reload.position).to eq(3)
            end

            it 'should decrement subject question\'s section\'s questions count by 1' do
              expect(subject[0].midas_survey_section_questions.count).to eq(9)
            end

            it 'should increment target question\'s section\'s questions count by 1' do
              expect(subject[1].midas_survey_section_questions.count).to eq(11)
            end
          end
        end

        context 'it is put after a question in a section that doesn\'t exist in the survey' do
          context 'first question in first section put after second question in first section' do
            before(:example) do
              first_survey = FactoryGirl.create(:survey, :with_midas_sections, number_of_sections: 2, with_midas_questions: true)
              second_survey = FactoryGirl.create(:survey, :with_midas_sections, number_of_sections: 2, with_midas_questions: true)
              first_survey_section = first_survey.midas_survey_sections[0]
              second_survey_section = second_survey.midas_survey_sections[0]
              first_survey_section.midas_survey_section_questions[0].put_after!(second_survey_section.midas_survey_section_questions[1].id)
              @subjects = [first_survey_section, second_survey_section]
            end

            subject { @subjects }

            it 'should retain subject question\'s section of first section' do
              expect(subject[0].midas_survey_section_questions[0].survey_section_id).to eq(subject[0].id)
            end

            it 'should retain subject question\'s position of first' do
              expect(subject[0].midas_survey_section_questions[0].position).to eq(1)
            end

            it 'should retain subject question\'s next question\'s of second' do
              expect(subject[0].midas_survey_section_questions[1].reload.position).to eq(2)
            end

            it 'should retain target questions\'s position of second' do
              expect(subject[1].midas_survey_section_questions[1].reload.position).to eq(2)
            end

            it 'should retain target question\'s next question\'s position of third' do
              expect(subject[1].midas_survey_section_questions[2].reload.position).to eq(3)
            end

            it 'should retain subject question\'s section\'s questions count of 10' do
              expect(subject[0].midas_survey_section_questions.count).to eq(10)
            end

            it 'should retain target question\'s section\'s questions count of 10' do
              expect(subject[1].midas_survey_section_questions.count).to eq(10)
            end
          end
        end

        context 'it is put before a question in a section that doesn\'t exist in the survey' do
          context 'first question in first section put before second question in first section' do
            before(:example) do
              first_survey = FactoryGirl.create(:survey, :with_midas_sections, number_of_sections: 2, with_midas_questions: true)
              second_survey = FactoryGirl.create(:survey, :with_midas_sections, number_of_sections: 2, with_midas_questions: true)
              first_survey_section = first_survey.midas_survey_sections[0]
              second_survey_section = second_survey.midas_survey_sections[0]
              first_survey_section.midas_survey_section_questions[0].put_before!(second_survey_section.midas_survey_section_questions[1].id)
              @subjects = [first_survey_section, second_survey_section]
            end

            subject { @subjects }

            it 'should retain subject question\'s section of first section' do
              expect(subject[0].midas_survey_section_questions[0].survey_section_id).to eq(subject[0].id)
            end

            it 'should retain subject question\'s position of first' do
              expect(subject[0].midas_survey_section_questions[0].position).to eq(1)
            end

            it 'should retain subject question\'s next question\'s of second' do
              expect(subject[0].midas_survey_section_questions[1].reload.position).to eq(2)
            end

            it 'should retain target questions\'s position of second' do
              expect(subject[1].midas_survey_section_questions[1].reload.position).to eq(2)
            end

            it 'should retain target question\'s next question\'s position of third' do
              expect(subject[1].midas_survey_section_questions[2].reload.position).to eq(3)
            end

            it 'should retain subject question\'s section\'s questions count of 10' do
              expect(subject[0].midas_survey_section_questions.count).to eq(10)
            end

            it 'should retain target question\'s section\'s questions count of 10' do
              expect(subject[1].midas_survey_section_questions.count).to eq(10)
            end
          end
        end
      end

      # context 'question is put at an invalid position' do

      #   context 'it is given a position less than 1' do
      #     before(:example) do
      #       section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 3)
      #       another_section_question = FactoryGirl.create(:section_question)
      #       @source_section_question = section.midas_survey_section_questions[1]
      #       @source_section_question.put_after!(another_section_question.id)
      #     end

      #     subject { @source_section_question }

      #     its(:position) { should eq(1) }
      #   end

      #   context 'it is given a position more than the number of questions in the section' do
      #     before(:example) do
      #       section = FactoryGirl.create(:section, :with_midas_questions, number_of_questions: 3)
      #       another_section_question = FactoryGirl.create(:section_question)
      #       @source_section_question = section.midas_survey_section_questions[1]
      #       @source_section_question.put_after!(another_section_question.id)
      #     end

      #     subject { @source_section_question }

      #     it 'should not be valid' do
      #       expect(subject).to_not be_valid
      #     end

      #     it 'should have an error on position' do
      #       expect(subject).to have(1).error_on(:position)
      #     end

      #     it 'should have an error message' do
      #       subject.valid?
      #       expect(subject.errors.messages[:position]).to include('is out of bound')
      #     end
      #   end
      # end
    end
  end
end
