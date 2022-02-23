class Recipe < ApplicationRecord

    belongs_to :recipe_type
    has_many :inputs
    has_many :outputs

    def self.get_by_input(item_id, recipe_type_id)
        Recipe.left_joins(:inputs).where(inputs: { item_id: item_id  }).left_joins(:recipe_type).where(recipe_type: { id: recipe_type_id })
    end

    def self.get_by_output(item_id, recipe_type_id)
        Recipe.left_joins(:outputs).where(outputs: { item_id: item_id  }).left_joins(:recipe_type).where(recipe_type: { id: recipe_type_id })
    end

end