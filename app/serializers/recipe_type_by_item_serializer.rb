class RecipeTypeByItemSerializer < ActiveModel::Serializer
    attributes :id, :name, :gui_url, :scale, :recipe_quantity
  
    def recipe_quantity
      42069
    end
    
  end