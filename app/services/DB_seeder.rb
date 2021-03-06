class DBSeeder

    RECIPE_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/recipes.json"
    ITEM_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/itemlist.json"
    ICON_PATH = ".Data-dumps/#{ENV["CURRENT_MODPACK"]}/itempanel_icons/*"

    def self.test
        json = JSON.parse(File.read(RECIPE_PATH))
        binding.pry
    end

    def self.main
        start = Time.now
        json = JSON.parse(File.read(RECIPE_PATH))
        puts "Recipe json loaded!"
        store_items(json)
        finish = Time.now
        puts "That took a whopping #{finish - start}s!"
    end

    def self.store_items(json)
        items = {}
        inputs = []
        outputs = []
        recipes = []
        recipe_types = []
        type_index = 1
        recipe_index = 1
        item_index = 1
        json["handlers"].each { |handler|
            recipe_types << make_recipe_type_params(handler)
            handler["r"].each_with_index { |recipe, index|
                recipes << make_recipe_params(recipe, type_index)
                get_inputs(recipe).each { |input|
                    anItem = input["items"][0]["item"]
                    if input["items"][0]["name"]
                        binding.pry
                    end
                    item_index = create_items(items, item_index, anItem)
                    inputs << {
                        recipe_id: recipe_index,
                        item_id: items["#{anItem["modid"]}.#{anItem["id"]}:#{anItem["metadata"]}"][:ind],
                        quantity: input["items"][0]["count"],
                        relx: input["relx"],
                        rely: input["rely"],
                        recipe_type_id: type_index
                    }
                }

                get_outputs(recipe).each { |output|
                    anItem = output["items"][0]["item"]
                    item_index = create_items(items, item_index, anItem)
                    outputs << {
                        recipe_id: recipe_index,
                        item_id: items["#{anItem["modid"]}.#{anItem["id"]}:#{anItem["metadata"]}"][:ind],
                        quantity: output["items"][0]["count"],
                        relx: output["relx"],
                        rely: output["rely"],
                        recipe_type_id: type_index
                    }
                }

                recipe_index += 1
            }
            type_index += 1
        }
        puts "Recipes loadded into RAM, localizing item names"
        items = localize_names(items)
        write_to_db({
            recipes: recipes,
            items: items,
            inputs: inputs,
            outputs: outputs,
            recipe_types: recipe_types
        })
    end

    def self.make_recipe_type_params(handler)
        return {
            name: handler["hn"],
            modID: handler["hi"],
            unlocalized_name: "#{handler["hi"]}@@#{handler["hn"]}"
        }
    end

    def self.make_recipe_params(recipe, type_index)
        power = nil
        duration = nil
        if recipe["e"]
            power = recipe["e"]["EUrate"]
            duration = recipe["e"]["duration"]
        end
        return { 
            recipe_type_id: type_index,
            power: power,
            duration: duration
        }
    end

    def self.get_inputs(recipe)
        if recipe["inputs"]
            return recipe["inputs"]
        else
            return recipe["i"]
        end
    end

    def self.get_outputs(recipe)
        if recipe["outputs"]
            return recipe["outputs"]
        elsif recipe["output"]
            return recipe["output"]
        else 
            return recipe["o"]
        end
    end

    def self.create_items(items, item_index, aItem)
        id = aItem["id"]
        modid = aItem["modid"]
        metadata = aItem["metadata"]
        localized_name = aItem["localized_name"]
        if !items["#{modid}.#{id}:#{metadata}"]
            items["#{modid}.#{id}:#{metadata}"] = {
                item_id: id,
                metadata: metadata,
                modid: modid,
                ind: item_index,
                unlocalized_name: "#{modid}.#{id}:#{metadata}",
                localized_name: localized_name,
                icon_url: nil
            }
            item_index += 1
        end
        return item_index
    end

    def self.localize_names(items)
        icon_names = get_icon_names
        item_json = JSON.parse(File.read(ITEM_PATH))
        item_json["items"].each { |item|
            if items["#{item["item"]["modid"]}.#{item["item"]["id"]}:#{item["item"]["metadata"]}"]
                items["#{item["item"]["modid"]}.#{item["item"]["id"]}:#{item["item"]["metadata"]}"][:localized_name] = item["name"]
                if icon_names[item["name"]]
                    items["#{item["item"]["modid"]}.#{item["item"]["id"]}:#{item["item"]["metadata"]}"][:icon_url] = "https://s3.us-east-2.amazonaws.com/item-icons-dev/icons/#{item["name"]}.png"
                end
            end
        }
        return items
    end

    def self.get_icon_names
        output = {}
        Dir[ICON_PATH].each do |path|
            localized_name = path[path.rindex("/") + 1..path.rindex(".") - 1]
            output[localized_name] = true
        end
        output
    end

    def self.write_to_db(data)
        puts "Importing #{data[:items].values.length} Items"
        Item.import data[:items].values
        puts "Importing #{data[:recipe_types].length} Recipe Maps"
        RecipeType.import data[:recipe_types]
        puts "Importing #{data[:recipes].length} Recipes"
        Recipe.import data[:recipes]
        puts "Importing #{data[:inputs].length} Inputs"
        Input.import data[:inputs]
        puts "Importing #{data[:outputs].length} Outputs"
        Output.import data[:outputs]
    end

end