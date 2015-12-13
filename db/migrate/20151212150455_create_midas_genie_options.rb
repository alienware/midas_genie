class CreateMidasGenieOptions < ActiveRecord::Migration
  def change
    create_table :midas_genie_options do |t|
      t.text :title, null: false, index: true
      t.text :description
      t.text :remark
      t.references :question, index: true
      t.datetime :deleted_at, index: true

      t.timestamps null: false
    end
  end
end
