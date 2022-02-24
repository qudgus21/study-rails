class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :creator
      t.text :content
      t.timestamps :updated_at
      t.timestamps :created_at
    end
  end
end
