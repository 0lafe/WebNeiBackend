class Api::Recipes::ItemsController < ApplicationController

    def show
        handler_id = Item.find(params[:id]).handler_ids.keys.first
        if params[:output]
            render json: Recipe.get_by_output(params[:id], handler_id).limit(10)
        else
            render json: Recipe.get_by_input(params[:id], handler_id).limit(10)
        end
    end

end