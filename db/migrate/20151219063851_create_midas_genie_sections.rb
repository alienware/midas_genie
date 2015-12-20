class CreateMidasGenieSections < ActiveRecord::Migration
  def change
    create_table :midas_genie_sections do |t|
      t.text :title, null: false, index: true
      t.text :description
      t.text :remark
      t.datetime :deleted_at, index: true
      t.integer :section_questions_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end
