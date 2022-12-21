class RemoveCreatedAtFromTagAssignments < ActiveRecord::Migration[7.0]
  def change
    remove_column :tag_assignments, :created_at, :string
  end
end
