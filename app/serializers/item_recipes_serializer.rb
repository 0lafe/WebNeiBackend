class ItemRecipesSerializer < ActiveModel::Serializer

    attributes :id, :input_handlers, :output_handlers, :input_quantities, :output_quantities

    def input_quantities
        output = {}
        object.input_handlers.each do |handler|
            output[handler.id] = Recipe.left_joins(:recipe_type).where(recipe_type: handler).left_joins(:inputs).where(inputs: { item_id: object.id }).count
        end
        output
    end

    def output_quantities
        output = {}
        object.output_handlers.each do |handler|
            output[handler.id] = Recipe.left_joins(:recipe_type).where(recipe_type: handler).left_joins(:outputs).where(outputs: { item_id: object.id }).count
        end
        output
    end

    def depreicated
        handlers = {}
        current = 0
        object.inputs.each { |input|
            if input.recipe.id != current
                current = input.recipe.id
                if handlers[input.recipe.recipe_type.id]
                    handlers[input.recipe.recipe_type.id] += 1
                else
                    handlers[input.recipe.recipe_type.id] = 1
                end
            end
        }
        handlers
    end

end
  