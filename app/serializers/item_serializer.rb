class ItemSerializer < ActiveModel::Serializer
  attributes :id, :unlocalized_name, :localized_name, :input_handlers, :output_handlers, :has_inputs, :has_outputs

end