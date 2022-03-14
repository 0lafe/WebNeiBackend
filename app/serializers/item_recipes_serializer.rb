class ItemRecipesSerializer < ActiveModel::Serializer

    attributes :id, :localized_name, :input_handlers, :output_handlers, :has_inputs, :has_outputs

    def input_handlers
        output = []
        RecipeType.left_joins(:inputs).where(inputs: { item_id: object.id }).uniq.each do |type|
            output << RecipeTypeByItemInputSerializer.new(type, scope: object.id)
        end
        output
    end

    def output_handlers
        output = []
        RecipeType.left_joins(:outputs).where(outputs: { item_id: object.id }).uniq.each do |type|
            output << RecipeTypeByItemOutputSerializer.new(type, scope: object.id)
        end
        output
    end

end
  