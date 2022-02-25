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

end