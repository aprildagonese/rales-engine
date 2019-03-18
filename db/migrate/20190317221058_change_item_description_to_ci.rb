class ChangeItemDescriptionToCi < ActiveRecord::Migration[5.2]
  def change
    enable_extension :citext
    change_column :items, :description, :citext
  end
end
