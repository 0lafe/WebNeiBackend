class ItemSerializer < ActiveModel::Serializer
  attributes :id, :unlocalized_name, :localized_name, :icon_url, :has_icon

  def has_icon
    if object.icon_url
      true
    else
      false
    end
  end

end