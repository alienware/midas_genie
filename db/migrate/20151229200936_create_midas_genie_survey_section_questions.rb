class CreateMidasGenieSurveySectionQuestions < ActiveRecord::Migration
  def change
    create_table :midas_genie_survey_section_questions do |t|
      t.integer :survey_section_id
      t.references :question, index: true
      t.datetime :deleted_at, index: true
      t.integer :position, index: true

      t.timestamps null: false
    end
    add_index :midas_genie_survey_section_questions, :survey_section_id, name: 'index_midas_genie_survey_section_questions_survey_section_id'
  end
end
