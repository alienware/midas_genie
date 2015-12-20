class CreateMidasGenieSurveySections < ActiveRecord::Migration
  def change
    create_table :midas_genie_survey_sections do |t|
      t.references :survey, index: true
      t.references :section, index: true
      t.datetime :deleted_at, index: true
      t.integer :postition, index: true

      t.timestamps null: false
    end
  end
end
