class RecipeTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :gui_url, :scale, :recipe_quantity, :icon_url, :has_icon

  def recipe_quantity
    object.recipes.count
  end

  def has_icon
    if object.icon_url
      true
    else
      false
    end
  end
  
end
