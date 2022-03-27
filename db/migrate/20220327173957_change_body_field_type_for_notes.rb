# frozen_string_literal: true

class ChangeBodyFieldTypeForNotes < ActiveRecord::Migration[6.1]
  def up
    change_column :notes, :body, :text
    change_column_null :notes, :private, false
  end

  def down
    change_column :notes, :body, :string
    change_column_null :notes, :private, true
  end
end
