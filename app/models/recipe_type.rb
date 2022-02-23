class RecipeType < ApplicationRecord

    validates :name, presence: true
    validates :modID, presence: true
    validates :unlocalized_name, presence: true
    has_many :recipes
    has_many :inputs
    has_many :outputs

end