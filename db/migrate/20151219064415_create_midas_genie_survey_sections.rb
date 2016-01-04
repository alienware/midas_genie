class CreateMidasGenieSurveySections < ActiveRecord::Migration
  def change
    create_table :midas_genie_survey_sections do |t|
      t.references :survey, index: true
      t.references :section, index: true
      t.datetime :deleted_at, index: true
      t.integer :position, index: true
      t.integer :survey_section_questions_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end
