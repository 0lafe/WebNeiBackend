class ItemIconLinker

    GUI_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/itempanel_icons/*"

    def self.link_images
        icons = {}
        Dir[GUI_PATH].each do |path|
            localized_name = path[path.rindex("/") + 1..path.rindex(".") - 1]
            icons[localized_name] = true
        end
        length = icons.keys.length
        Item.all.each_with_index do |item, index|
            if icons[item.localized_name]
                puts "saving #{index}/#{length}"
                item.icon_url = "https://s3.us-east-2.amazonaws.com/item-icons-dev/#{item.localized_name}.png"
                item.save
            end
        end
        puts "Item Icons Linked to Items"
    end

end