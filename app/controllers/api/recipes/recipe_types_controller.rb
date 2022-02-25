class Api::Recipes::RecipeTypesController < ApplicationController

    def index

    end

    def show
        if params[:item_id]
            render json: RecipeReader.include_item(params)
        else
            render json: RecipeReader.by_handler(params)
        end
    end

end