class RecipeReader

    #dictates what search type is being preformed
    def self.recipe_show(params)
        if params[:searchType] == "handler"
            return get_handler(params)
        end
        if params[:searchType] == "item"
            return get_item(params)
        end
    end

    private

    #returns search for a recipe handler
    def self.get_handler(params)
        RecipeType.find(params[:id]).recipes.limit(params[:perPage]).offset((params[:page].to_i - 1) * params[:perPage].to_i)
    end

    #returns recipes involving an item as an input
    def self.get_item(params)
        if (params[:handler] == "null")
            starting_point = Item.find(params[:id]).handler_ids.keys[0]
            RecipeType.find(starting_point).recipes.where(inputs: Input.where(item: Item.find(params[:id]))).limit(params[:perPage]).offset((params[:page].to_i - 1) * params[:perPage].to_i)
        else
            RecipeType.find(params[:handler]).recipes.where(inputs: Input.where(item: Item.find(params[:id]))).limit(params[:perPage])
        end
    end

    def self.include_item(params)
        offset = 0
        if params[:offset]
            offset = params[:offset]
        end
        if params[:output]
            return Recipe.get_by_output(params[:item_id], params[:id]).limit(10).offset(offset)
        else
            return Recipe.get_by_input(params[:item_id], params[:id]).limit(10).offset(offset)
        end
    end

    def self.by_handler(params)
        offset = 0
        if params[:offset]
            offset = params[:offset]
        end
        RecipeType.find(params[:id]).recipes.limit(10).offset(offset)
    end

end