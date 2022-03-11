class RecipeTypeByItemOutputSerializer < ActiveModel::Serializer
  attributes :id, :name, :gui_url, :scale, :recipe_quantity

  def recipe_quantity
    Recipe.left_joins(:recipe_type).where(recipe_type: object).left_joins(:outputs).where(outputs: { item_id: scope }).count
  end
    
end