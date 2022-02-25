class Input < ApplicationRecord
    belongs_to :item
    belongs_to :recipe
    belongs_to :recipe_type
end