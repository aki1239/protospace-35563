class RemoveImageFromPrototypes < ActiveRecord::Migration[6.0]
  def change
    remove_column :prototypes, :image, :text
  end
end
