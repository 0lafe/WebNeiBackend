class RecipeTypeByItemInputSerializer < ActiveModel::Serializer
  attributes :id, :name, :gui_url, :scale, :recipe_quantity, :icon_url, :has_icon

  def recipe_quantity
    Recipe.left_joins(:recipe_type).where(recipe_type: object).left_joins(:inputs).where(inputs: { item_id: scope }).distinct.count
  end

  def has_icon
    if object.icon_url
      true
    else
      false
    end
  end
    
end