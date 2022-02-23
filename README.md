# WiP Backend

# Data dump locations

https://drive.google.com/drive/folders/1gvyB35U5ZeEdYljkxrD1SqlJ7sdkMyjr?usp=sharing
Drop this file into your root directory of this git project. You will need to unzip the GUI.zip file

Set the `CURRENT_MODPACK` variable in your .env file to the folder of the modpack you want to develop for. 

run `rake recipes:store` and `rake recipes:gui`

`.Data-dumps/MODPACK/recipes.json`
`.Data-dumps/MODPACK/itemlist.json`
`.Data-dumps/MODPACK/guis/`

# Use

This project exposes many API endpoints for getting recipe and item data. 

all routes include these props 
`offset=int` offsets search


`/api/recipes/items/:id` will return recipes for an item in its first recipe handler
`/api/recipes/items/:id/recipe_types/:id` will return recipes for an item in a given recipe handler
Params include 
`output=true` switches from recipes including item as an input to an output


`/api/recipes/recipe_types/:id` will return all recipes for a recipe handler

