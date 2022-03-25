# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.boolean :private, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
