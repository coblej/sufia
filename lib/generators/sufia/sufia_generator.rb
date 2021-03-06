# -*- encoding : utf-8 -*-
require 'rails/generators'
require 'rails/generators/migration'

class SufiaGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  argument :model_name, :type => :string , :default => "user"
  desc """
This generator makes the following changes to your application:
 1. Runs sufia-models:install
 2. Adds Sufia's abilities into the Ability class
 3. Adds controller behavior to the application controller
 4. Copies the catalog controller into the local app
       """

  def run_required_generators
    generate "blacklight:install --devise"
    generate "hydra:head -f"
    generate "sufia:models:install"
  end

  def insert_abilities
    insert_into_file 'app/models/ability.rb', after: /Hydra::Ability/ do
      "\n  include Sufia::Ability\n"
    end
  end

  # Add behaviors to the application controller
  def inject_sufia_controller_behavior
    controller_name = "ApplicationController"
    file_path = "app/controllers/application_controller.rb"
    if File.exists?(file_path)
      insert_into_file file_path, :after => 'include Blacklight::Controller' do
        "  \n# Adds Sufia behaviors into the application controller \n" +
        "  include Sufia::Controller\n"
      end
      gsub_file file_path, "layout 'blacklight'", "layout :search_layout"
    else
      puts "     \e[31mFailure\e[0m  Could not find #{file_path}.  To add Sufia behaviors to your Controllers, you must include the Sufia::Controller module in the Controller class definition."
    end
  end

  def catalog_controller
    copy_file "catalog_controller.rb", "app/controllers/catalog_controller.rb"
  end

  def tinymce_config
    copy_file "config/tinymce.yml", "config/tinymce.yml"
  end

  # The engine routes have to come after the devise routes so that /users/sign_in will work
  def inject_routes
    routing_code = "\n  Hydra::BatchEdit.add_routes(self)\n" +
      "  # This must be the very last route in the file because it has a catch-all route for 404 errors.
  # This behavior seems to show up only in production mode.
  mount Sufia::Engine => '/'\n"

    sentinel = /devise_for :users/
    inject_into_file 'config/routes.rb', routing_code, { :after => sentinel, :verbose => false }
  end
end
