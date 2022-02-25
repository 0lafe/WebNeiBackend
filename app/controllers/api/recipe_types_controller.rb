class Api::RecipeTypesController < ApplicationController

    def index
        
        render json: {handlers: handlers}
    end

    def show
        render json: RecipeType.find(params[:id])
    end

end