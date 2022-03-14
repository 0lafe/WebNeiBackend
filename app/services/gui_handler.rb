require 'fastimage'

class GUIHandler 

    GUI_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/guis/*"
    LINKING_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/handler_icon_mapping.json"
    SEPARATOR = "@@"
    NEW_WIDTH = 1000

    def self.handle
        icon_mappings = JSON.parse(File.read(LINKING_PATH))
        Dir[GUI_PATH].each { |path| 
            unlocalized_name = path[path.rindex("/") + 1..path.rindex(".") - 1]
            aHandler = RecipeType.find_by(unlocalized_name: unlocalized_name)
            aHandler.gui_url = "#{unlocalized_name}.png"
            aHandler.scale = ((NEW_WIDTH / FastImage.size(path)[0].to_f) * 100).to_i
            aHandler.icon_name = Item.find_by(localized_name: icon_mappings["crafting"]).icon_url
            aHandler.save
        }
        puts "GUIs linked to handlers"
    end

end