class ItemRecipesSerializer < ActiveModel::Serializer

    attributes :input_handlers, :output_handlers, :input_quantities, :output_quantities

    def input_quantities
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

    def output_quantities
        handlers = {}
        current = 0
        object.outputs.each { |output|
            if output.recipe.id != current
                current = output.recipe.id
                if handlers[output.recipe.recipe_type.id]
                    handlers[output.recipe.recipe_type.id] += 1
                else
                    handlers[output.recipe.recipe_type.id] = 1
                end
            end
        }
        handlers
    end

end
  