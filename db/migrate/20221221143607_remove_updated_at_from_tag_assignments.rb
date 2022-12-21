class RemoveUpdatedAtFromTagAssignments < ActiveRecord::Migration[7.0]
  def change
    remove_column :tag_assignments, :updated_at, :string
  end
end
