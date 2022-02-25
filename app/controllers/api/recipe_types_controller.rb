class Api::RecipeTypesController < ApplicationController

    def index
        render json: RecipeType.all.left_joins(:recipes).group(:id).order('COUNT(recipes.id) DESC')
    end

    def show
        render json: RecipeType.find(params[:id])
    end

end