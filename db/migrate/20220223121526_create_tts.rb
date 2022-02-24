class CreateTts < ActiveRecord::Migration
  def change
    create_table :tts do |t|
      t.string :name
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
