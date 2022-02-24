class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      # t.references :post, null: false, foreign_key: true
      t.belongs_to :post
      t.string :creator
      t.text :content
      t.timestamps :updated_at
      t.timestamps :created_at
    end
  end
end
