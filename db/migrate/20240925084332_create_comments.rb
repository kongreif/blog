# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end

    add_foreign_key :comments, :comments, column: :parent_id
    add_index :comments, :parent_id
  end
end
