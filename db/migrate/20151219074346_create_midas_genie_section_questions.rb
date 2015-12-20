class CreateMidasGenieSectionQuestions < ActiveRecord::Migration
  def change
    create_table :midas_genie_section_questions do |t|
      t.references :section, index: true
      t.references :question, index: true
      t.datetime :deleted_at, index: true
      t.integer :position, index: true

      t.timestamps null: false
    end
  end
end
