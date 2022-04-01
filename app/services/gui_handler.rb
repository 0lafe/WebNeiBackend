require 'fastimage'

class GUIHandler 
    GUI_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/guis/*"
    LINKING_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/gui_mappings.json"
    SEPARATOR = "@@"
    NEW_WIDTH = 1000

    def self.handle
        icon_mappings = JSON.parse(File.read(LINKING_PATH))
        Dir[GUI_PATH].each { |path| 
            unlocalized_name = path[path.rindex("/") + 1..path.rindex(".") - 1]
            aHandler = RecipeType.find_by(unlocalized_name: unlocalized_name)
            if aHandler
                aHandler.gui_url = "#{unlocalized_name}.png"
                aHandler.scale = ((NEW_WIDTH / FastImage.size(path)[0].to_f) * 100).to_i
                item = Item.find_by(localized_name: aHandler.name)
                if icon_mappings[aHandler.name]
                    aHandler.icon_url = Item.find_by(localized_name: icon_mappings[aHandler.name]).icon_url
                elsif item
                    aHandler.icon_url = item.icon_url
                else
                    aHandler.icon_url = Item.find_by(localized_name: "Crafting Table").icon_url
                end
                aHandler.save
            end
        }
        puts "GUIs linked to handlers"
    end

end