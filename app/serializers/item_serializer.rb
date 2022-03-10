class ItemSerializer < ActiveModel::Serializer
  attributes :id, :unlocalized_name, :localized_name

end