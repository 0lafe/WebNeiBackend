class Api::Recipes::RecipeTypesController < ApplicationController

    def index

    end

    def show
        if params[:item_id]
            render json: RecipeReader.include_item(params), include: ['inputs.item', 'outputs.item']
        else
            render json: RecipeReader.by_handler(params), include: ['inputs.item', 'outputs.item']
        end
    end

end