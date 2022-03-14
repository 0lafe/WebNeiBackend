namespace :recipes do |args|

    desc "seeds database with Recipe data"
    task :store => [ :environment ] do
        DBSeeder.main
    end

    desc "Links GUIs to Types"
    task :gui => [ :environment ] do
        GUIHandler.handle
    end

    desc "Links icons to Items"
    task :icons => [ :environment ] do
        ItemIconLinker.link_images
    end

    desc "Full db setup"
    task :seed => [ :environment ] do
        DBSeeder.main
        GUIHandler.handle
        # ItemIconLinker.link_images
    end

    task :upload => [ :environment ] do
        ItemIconLinker.upload_images
    end

    task :test => [ :environment ] do
        DBSeeder.test
    end

end