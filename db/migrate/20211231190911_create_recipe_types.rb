class CreateRecipeTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_types do |t|
      t.string :name, null: false
      t.string :modID, null: false
      t.string :unlocalized_name, null: false
      t.string :gui_url
      t.string :icon_url
      t.integer :scale
    end
  end
end
