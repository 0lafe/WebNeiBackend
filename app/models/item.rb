class Item < ApplicationRecord

    validates :item_id, presence: true
    validates :metadata, presence: true
    validates :modid, presence: true

    has_many :inputs
    has_many :outputs

    def input_handlers
        RecipeType.left_joins(:inputs).where(inputs: { item_id: self.id }).uniq 
    end

    def output_handlers
        RecipeType.left_joins(:outputs).where(outputs: { item_id: self.id }).uniq
    end

    def has_inputs
        self.inputs.length > 0
    end

    def has_outputs
        self.outputs.length > 0
    end

end