# frozen_string_literal: true

class AddExcerptToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :excerpt, :text
  end
end
