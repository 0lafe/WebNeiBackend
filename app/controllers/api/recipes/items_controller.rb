class Api::Recipes::ItemsController < ApplicationController

    def show
        render json: Item.find(params[:id]), serializer: ItemRecipesSerializer
    end

end